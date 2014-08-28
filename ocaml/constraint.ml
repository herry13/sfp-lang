open Common
open Domain

let rec apply store _constraint =
	match _constraint with
	| Eq (r, v) -> (
			match find store r with
			| Val (Basic v1) -> v = v1
			| _ -> false
		)
	| Ne (r, v) -> (
			match find store r with
			| Val (Basic v1) -> v <> v1
			| _ -> false
		)
	| Not c1 -> not (apply store c1)
	| Imply (c1, c2) -> not (apply store c1) || (apply store c2)
	| In (r, vec) -> (
			match find store r with
			| Val (Basic v1) -> List.mem v1 vec
			| _ -> false
		)
	| And clauses -> (
			let rec iter clauses =
				match clauses with
				| [] -> true
				| head :: tail ->
					if not (apply store head) then false
					else iter tail
			in
			iter clauses
		)
	| Or clauses -> (
			let rec iter cs =
				match cs with
				| [] -> false
				| head :: tail ->
					if apply store head then true
					else iter tail
			in
			if clauses = [] then true
			else iter clauses
		)
	| _ -> error 800

(**
 * mode:
 * - 1 = Equality
 * - 2 = NotEquality
 * - 3 = Membership
 * - 4 = NotMembership
 * - 5 = GreaterThan
 * - 6 = GreaterOrEqualsThan
 * - 7 = LessThan
 * - 8 = LessOrEqualsThan
 *)
let rec nested_to_prevail reference value variables typeEnvironment mode =
	let rec prevail_of r =
		if r = [] then error 507
		else if Variable.mem r variables then r
		else prevail_of (prefix r)
	in
	let rec iter r cs =
		let prevail = prevail_of r in
		if prevail = r then
			match mode, value with
			| 1, _          -> (Eq (r, value)) :: cs
			| 2, _          -> (Ne (r, value)) :: cs
			| 3, Vector vec -> (In (r, vec)) :: cs
			| 4, Vector vec -> (Not (In (r, vec))) :: cs
			| 5, _          -> (Greater (r, value)) :: cs
			| 6, _          -> (GreaterEqual (r, value)) :: cs
			| 7, _          -> (Less (r, value)) :: cs
			| 8, _          -> (LessEqual (r, value)) :: cs
			| _             -> error 508
		else
			let cs1 = (Ne (prevail, Null)) :: cs in
			let rs1 = r @-- prevail in
			Array.fold_left (
				fun acc vp ->
					match vp with
					| Basic (Ref rp) ->
						let premise = Eq (prevail, Ref rp) in
						let conclusion = And (iter (rp @++ rs1) []) in
						(Imply (premise, conclusion)) :: acc
					| Basic Null     -> acc
					| _              -> error 509
			) cs1 (Variable.values_of prevail variables)
	in
	And (iter reference [])

(**
 * simplify a conjunction formula
 * - remove duplications
 * - determine whether the formula is always false
 *)
and simplify_conjunction conjunction =
	let rec iter clauses acc =
		match clauses with
		| []         -> And acc
		| c1 :: tail -> 
			if List.exists (fun c2 ->
					(* return false if formula 'c1' negates 'c2'
					   (or vice versa), otherwise true *)
					match c1, c2 with
					| Eq (r1, v1), Eq (r2, v2) ->
						if r1 = r2 then not (v1 = v2) else false
					| Eq (r1, v1), Ne (r2, v2) ->
						if r1 = r2 then v1 = v2 else false
					| Ne (r1, v1), Eq (r2, v2) ->
						if r1 = r2 then v1 = v2 else false
					| _ -> false
				) tail then False
			else if List.mem c1 tail then iter tail acc
			else iter tail (c1 :: acc)
	in
	match conjunction with
	| And clauses -> iter clauses []
	| _           -> error 510

(**
 * simplify a disjunction formula
 * - remove duplications
 *)
and simplify_disjunction disjunction =
	let rec iter clauses acc =
		match clauses with
		| [] -> Or acc
		| clause :: tail ->
			if List.mem clause tail then iter tail acc
			else iter tail (clause :: acc)
	in
	match disjunction with
	| Or clauses -> iter clauses []
	| _          -> error 511

(**
 * cross product of disjunction clauses of a conjunction formula
 * @param ands conjunction clauses of the formula
 * @param ors  disjunction clauses of the formula
 *)
and cross_product_of andClauses orClauses =
	let cross clauses1 clauses2 =
		List.fold_left (fun acc1 clause1 ->
			List.fold_left (fun acc2 clause2 ->
				(And [clause1; clause2]) :: acc2
			) acc1 clauses2
		) [] clauses1
	in
	let rec iter clauses =
		match clauses with
		| []            -> []
		| (Or cs) :: [] ->
			List.fold_left (
				fun acc c ->
					match c with
					| And css ->
						(simplify_conjunction (
							And (List.append css andClauses))
						) :: acc
					| _       -> error 512
			) [] cs
		| (Or cs1) :: (Or cs2) :: tail -> iter ((Or (cross cs1 cs2)) :: tail)
		| _ -> error 513
	in
	dnf_of (Or (iter orClauses))

(** convert a constraint formula to a DNF formula **)
and dnf_of _constraint variables typeEnvironment =
	match _constraint with
	| Eq (r, v)      -> dnf_of_equal r v variables typeEnvironment
	| Ne (r, v)      -> dnf_of_not_equal r v variables typeEnvironment
	| Not c1         -> dnf_of_negation c1 variables typeEnvironment
	| Imply (c1, c2) -> dnf_of_implication c1 c2 variables typeEnvironment
	| In (r, vec)    -> dnf_of_membership r vec variables typeEnvironment
	| And cs         -> dnf_of_conjunction cs variables typeEnvironment
	| Or cs          -> dnf_of_disjunction cs variables typeEnvironment
	| Greater (r, v) ->
		dnf_of_numeric r v variables typeEnvironment (fun x1 x2 -> x1 > x2)
	| GreaterEqual (r, v) ->
		dnf_of_numeric r v variables typeEnvironment (fun x1 x2 -> x1 >= x2)
	| Less (r, v) ->
		dnf_of_numeric r v variables typeEnvironment (fun x1 x2 -> x1 < x2)
	| LessEqual (r, v) ->
		dnf_of_numeric r v variables typeEnvironment (fun x1 x2 -> x1 <= x2)
	| _ -> error 550

and dnf_of_numeric r v vars env comparator =
	let convert x =
		let values =
			Array.fold_left (
				fun acc v1 -> (
					match v1 with
					| Basic (Int i)   -> if comparator (float_of_int i) x then (Int i) :: acc else acc
					| Basic (Float f) -> if comparator f x then (Float f) :: acc else acc
					| _               -> error 552
				)
			) [] (Variable.values_of r vars)
		in
		if values = [] then False
		else dnf_of (In (r, values)) vars env
	in
	if Variable.mem r vars then (
		match v with
		| Int i   -> convert (float_of_int i)
		| Float f -> convert f
		| Ref r1   -> (
				if Variable.mem r1 vars then error 553 (* TODO: right-hand is a reference *)
				else error 554 (* right-hand is nested reference *)
			)			
		| _       -> error 551
	) else dnf_of (nested_to_prevail r v vars env 5) vars env

(** convert equality to DNF, and convert a left-nested reference to prevail
    ones **)
and dnf_of_equal reference value variables typeEnvironment =
	if Variable.mem reference variables then
		Eq (reference, value)
	else
		dnf_of (nested_to_prevail reference value variables typeEnvironment 1)
			variables typeEnvironment

(** convert inequality to DNF, and convert a left-nested reference to
    prevail ones **)
and dnf_of_not_equal reference value variables typeEnvironment =
	if Variable.mem reference variables then
		let values =
			Array.fold_left (
				fun acc v ->
					match v with
					| Basic bv -> if bv = value then acc else bv :: acc
					| _  -> error 514
						(* the right-hand side is not a basic value *)
			) [] (Variable.values_of reference variables)
		in
		if values = [] then False
		else dnf_of (In (reference, values)) variables typeEnvironment
	else
		dnf_of (nested_to_prevail reference value variables typeEnvironment 2)
			variables typeEnvironment

(** convert negation to DNF **)
and dnf_of_negation _constraint variables typeEnvironment =
	match _constraint with
	| True -> False
	| False -> True
	| Eq (r, v) -> dnf_of (Ne (r, v)) variables typeEnvironment
	| Ne (r, v) -> dnf_of (Eq (r, v)) variables typeEnvironment
	| Greater (r, v) -> dnf_of (LessEqual (r, v)) variables typeEnvironment
	| GreaterEqual (r, v) -> dnf_of (Less (r, v)) variables typeEnvironment
	| Less (r, v) -> dnf_of (GreaterEqual (r, v)) variables typeEnvironment
	| LessEqual (r, v) -> dnf_of (Greater (r, v)) variables typeEnvironment
	| Not c1 -> dnf_of c1 variables typeEnvironment
	| Imply (premise, conclusion) ->
		(* -(p -> q) = p ^ -q *)
		dnf_of (And [premise; (Not conclusion)]) variables typeEnvironment
	| And cs ->
		(* De Morgan's laws *)
		let cs1 = List.fold_left (fun acc c -> (Not c) :: acc) [] cs in
		dnf_of (Or cs1) variables typeEnvironment
	| Or cs  ->
		(* De Morgan's laws *)
		let cs1 = List.fold_left (fun acc c -> (Not c) :: acc) [] cs in
		dnf_of (And cs1) variables typeEnvironment
	| In (r, vector) ->
		if Variable.mem r variables then
			let cs = Array.fold_left (
					fun acc v ->
						match v with
						| Basic v1 ->
							if List.mem v1 vector then acc
							else (Eq (r, v1)) :: acc
						| _        -> error 515
				) [] (Variable.values_of r variables)
			in
			if cs = [] then False
			else dnf_of (Or cs) variables typeEnvironment
		else
			dnf_of (nested_to_prevail r (Vector vector) variables
				typeEnvironment 4) variables typeEnvironment

(** convert implication to DNF **)
and dnf_of_implication premise conclusion variables typeEnvironment =
	dnf_of (Or [(Not premise); conclusion]) variables typeEnvironment

(** convert membership constraint to DNF **)
and dnf_of_membership reference vector variables typeEnvironment =
	if Variable.mem reference variables then
		let clauses = Array.fold_left (
				fun acc value ->
					match value with
					| Basic v ->
						if List.mem v vector then (Eq (reference, v)) :: acc
						else acc
					| _        -> error 516
			) [] (Variable.values_of reference variables)
		in
		if clauses = [] then False
		else dnf_of (Or clauses) variables typeEnvironment
	else
		dnf_of (nested_to_prevail reference (Vector vector) variables
			typeEnvironment 3) variables typeEnvironment

(** convert conjunction to DNF, performs cross-products when it has disjunction clause **)
and dnf_of_conjunction clauses variables typeEnvironment =
	let rec iter clauses ands ors =
		if clauses = [] then (false, ands, ors)
		else
			match dnf_of (List.hd clauses) variables typeEnvironment with
			| And css -> iter (List.tl clauses) (List.append css ands) ors
			| False   -> (true, ands, ors)
			| True    -> iter (List.tl clauses) ands ors
			| Or css  -> iter (List.tl clauses) ands ((Or css) :: ors)
			| css     -> iter (List.tl clauses) (css :: ands) ors
	in
	match clauses with
	| [] -> True
	| _  ->
		let (allFalse, andClauses, orClauses) = iter clauses [] [] in
		if allFalse then False
		else
			match andClauses, orClauses with
			| [], []         -> True
			| head :: [], [] -> head
			| [], head :: [] -> head
			| _, []          -> simplify_conjunction (And andClauses)
			| _, _           ->
				(cross_product_of andClauses orClauses) variables
					typeEnvironment

(** convert disjunction to DNF **)
and dnf_of_disjunction clauses variables typeEnvironment =
	let rec iter clauses acc =
		if clauses = [] then (false, acc)
		else
			match dnf_of (List.hd clauses) variables typeEnvironment with
			| Or cs -> iter (List.tl clauses) (List.append cs acc)
			| False -> iter (List.tl clauses) acc
			| True  -> (true, acc)
			| c     -> iter (List.tl clauses) (c :: acc)
	in
	match clauses with
	| [] -> True
	| _ ->
		let (allTrue, clauses1) = iter clauses [] in
		if allTrue then True
		else
			match clauses1 with
			| clause :: [] -> clause
			| _            -> simplify_disjunction (Or clauses1)
;;

(**
 * substitute each parameter with a value as specified in the map of
 * parameters
 *)
let rec substitute_free_variables_of _constraint parameters =
	match _constraint with
	| Eq (r, v) ->
		let r1 = substitute_parameter_of_reference r parameters in
		let v1 = substitute_parameter_of_basic_value v parameters in
		Eq (r1, v1)
	| Ne (r, v) ->
		let r1 = substitute_parameter_of_reference r parameters in
		let v1 = substitute_parameter_of_basic_value v parameters in
		Ne (r1, v1)
	| Greater (r, v) ->
		let r1 = substitute_parameter_of_reference r parameters in
		let v1 = substitute_parameter_of_basic_value v parameters in
		Greater (r1, v1)
	| GreaterEqual (r, v) ->
		let r1 = substitute_parameter_of_reference r parameters in
		let v1 = substitute_parameter_of_basic_value v parameters in
		GreaterEqual (r1, v1)
	| Less (r, v) ->
		let r1 = substitute_parameter_of_reference r parameters in
		let v1 = substitute_parameter_of_basic_value v parameters in
		Less (r1, v1)
	| LessEqual (r, v) ->
		let r1 = substitute_parameter_of_reference r parameters in
		let v1 = substitute_parameter_of_basic_value v parameters in
		LessEqual (r1, v1)
	| Not c ->
		Not (substitute_free_variables_of c parameters)
	| Imply (c1, c2) ->
		Imply (
			substitute_free_variables_of c1 parameters,
			substitute_free_variables_of c2 parameters
		)
	| And cs ->
		And (
			List.fold_left (
				fun css c -> (substitute_free_variables_of c parameters) :: css
			) [] cs
		)
	| Or cs ->
		Or (
			List.fold_left (
				fun css c -> (substitute_free_variables_of c parameters) :: css
			) [] cs
		)
	| In (r, v) ->
		let r1 = substitute_parameter_of_reference r parameters in
		In (r1, v)	
	| _ -> error 1001
;;


(************************************************************************
 * Functions for global constraints.
 ************************************************************************)

type data = {
	complex   : _constraint list;
	simple    : _constraint list;
	variables : Variable.ts
}

(** compile simple membership of global constraints **)
let compile_membership isNegation reference vector data =
	let rec prevail_of r =
		if r = [] then error 507
		else if Variable.mem r data.variables then r
		else prevail_of (prefix r)
	in
	let prevail = prevail_of reference in
	if prevail = reference then
		{
			complex   = data.complex;
			simple    = data.simple;
			variables =
				if isNegation then
					Variable.remove_values_from reference vector
						data.variables
				else
					Variable.intersection_with_values reference vector
						data.variables
		}
	else
		let variables1 = Variable.remove_value_from prevail (Basic Null)
			data.variables
		in
		let rs = reference @-- prevail in
		let accumulator = {
				complex   = data.complex;
				simple    = data.simple;
				variables = variables1
			}
		in
		let values = Variable.values_of prevail variables1 in
		Array.fold_left (fun acc v ->
			match v with
			| Basic (Ref r) ->
				let r1 = r @++ rs in
				let c =
					if isNegation then
						Imply (Eq (prevail, Ref r), Not (In (r1, vector)))
					else
						Imply (Eq (prevail, Ref r), In (r1, vector))
				in
				{
					complex   = c :: acc.complex;
					simple    = acc.simple;
					variables = acc.variables
				}
			| _ -> error 508
		) accumulator values
;;

(** compile simple equality of global constraints **)
let compile_equality isNegation reference value data =
	let rec prevail_of r =
		if r = [] then error 509
		else if Variable.mem r data.variables then r
		else prevail_of (prefix r)
	in
	let prevail = prevail_of reference in
	if prevail = reference then
		{
			complex   = data.complex;
			simple    = data.simple;
			variables =
				if isNegation then
					Variable.remove_value_from reference (Basic value)
						data.variables
				else
					Variable.intersection_with_value reference (Basic value)
						data.variables
		}
	else 
		let variables1 = Variable.remove_value_from prevail (Basic Null)
			data.variables
		in
		let rs = reference @-- prevail in
		let accumulator = {
				complex   = data.complex;
				simple    = data.simple;
				variables = variables1
			}
		in
		let values = Variable.values_of prevail variables1 in
		Array.fold_left (fun acc v ->
			match v with
			| Basic (Ref r) ->
				let r1 = r @++ rs in
				let _constraint =
					if isNegation
						then Imply (Eq (prevail, Ref r), Ne (r1, value))
					else
						Imply (Eq (prevail, Ref r), Eq (r1, value))
				in
				if not isNegation && (Variable.mem r1 acc.variables)
					then {
						complex = acc.complex;
						simple = _constraint :: acc.simple;
						variables = acc.variables
					}
				else
					{
						complex = _constraint :: acc.complex;
						simple = acc.simple;
						variables = acc.variables
					}
			| _ -> error 510
		) accumulator values
;;

(** compile simple equality and membership of global constraints **)
let compile_simple_constraints globalConstraints variables =
	match globalConstraints with
	| And clauses ->
		let accumulator = {
				complex   = [];
				simple    = [];
				variables = variables
			}
		in
		let data =
			List.fold_left (fun acc clause ->
				match clause with
				| Eq (r, v)         -> compile_equality false r v acc
				| Not (Eq (r, v))   -> compile_equality true r v acc
				| Ne (r, v)         -> compile_equality true r v acc
				| Not (Ne (r, v))   -> compile_equality false r v acc
				| In (r, vec)       -> compile_membership false r vec acc
				| Not (In (r, vec)) -> compile_membership true r vec acc
				| Imply (Eq (_, _), Eq (_, _)) -> {
						complex   = acc.complex;
						simple    = clause :: acc.simple;
						variables = acc.variables
					}
				| Imply (Eq (r, v), And clauses) -> (
						let eq = Eq (r, v) in
						List.fold_left (fun (acc: data) (c: _constraint) ->
							match c with
							| Eq (_, _) ->
								{
									complex   = acc.complex;
									simple    = (Imply (eq, clause)) ::
										            acc.simple;
									variables = acc.variables
								}
							| _ ->
								{
									complex   = (Imply (eq, clause)) ::
										            acc.complex;
									simple    = acc.simple;
									variables = acc.variables
								}
						) acc clauses
					)
				| _ ->
					{
						complex   = clause :: acc.complex;
						simple    = acc.simple;
						variables = acc.variables
					}
			) accumulator clauses
		in
		(And data.complex, data.simple, data.variables)
	| _  -> (globalConstraints, [], variables)
;;

(**
 * This function performs:
 * 1. find the global constraints in given flat-store
 * 2. modify variables' domain based on 'membership' constraints
 * 3. separate simple implication clauses from the global constraints formula
 *    with others
 * 4. convert the other clauses (complex formula) into a DNF formula 
 *)
let global_of typeEnvironment flatStore variables =
	let referenceGlobal = ["global"] in
	if MapRef.mem referenceGlobal flatStore then
		match MapRef.find referenceGlobal flatStore with
		| Global globalConstraints ->
			let (globalConstraints1, globalImplications, variables1) =
				compile_simple_constraints globalConstraints variables
			in
			let dnfGlobalConstraints1 = dnf_of globalConstraints1
				variables typeEnvironment
			in
			(dnfGlobalConstraints1, globalImplications, variables1)
		| _ -> error 519
	else (True, [], variables)
;;
