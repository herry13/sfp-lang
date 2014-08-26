open Common
open Domain

let rec apply (s: store) (c: _constraint) : bool =
	match c with
	| Eq (r, v) -> (
			match find s r with
			| Val (Basic v1) -> v = v1
			| _ -> false
		)
	| Ne (r, v) -> (
			match find s r with
			| Val (Basic v1) -> v <> v1
			| _ -> false
		)
	| Not c1 -> not (apply s c1)
	| Imply (c1, c2) -> not (apply s c1) || (apply s c2)
	| In (r, vec) -> (
			match find s r with
			| Val (Basic v1) -> List.mem v1 vec
			| _ -> false
		)
	| And cs -> (
			let rec iter cs =
				match cs with
				| [] -> true
				| head :: tail -> if not (apply s head) then false else iter tail
			in
			iter cs
		)
	| Or cs -> (
			let rec iter cs =
				match cs with
				| [] -> false
				| head :: tail -> if apply s head then true else iter tail
			in
			if cs = [] then true else iter cs
		)
	| _ -> error 800

(* mode: {1 => Eq, 2 => Ne, 3 => In, 4 => NotIn } *)
let rec compile_nested r v vars env mode =
	let rec prevail_of rx =
		if rx = [] then error 507
		else if Variable.mem rx vars then rx
		else prevail_of (prefix rx)
	in
	let rec iter r cs =
		let prevail = prevail_of r in
		if prevail = r then
			match mode, v with
			| 1, _          -> (Eq (r, v)) :: cs
			| 2, _          -> (Ne (r, v)) :: cs
			| 3, Vector vec -> (In (r, vec)) :: cs
			| 4, Vector vec -> (Not (In (r, vec))) :: cs
			| 5, _          -> (Greater (r, v)) :: cs
			| 6, _          -> (GreaterEqual (r, v)) :: cs
			| 7, _          -> (Less (r, v)) :: cs
			| 8, _          -> (LessEqual (r, v)) :: cs
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
			) cs1 (Variable.values_of prevail vars)
	in
	And (iter r [])

(**
 * simplify a conjunction formula
 * - remove duplications
 * - determine whether the formula is always false
 *)
and simplify_conjunction c =
	let rec iter clauses acc =
		match clauses with
		| []         -> And acc
		| c1 :: tail -> 
			if List.exists (fun c2 ->
					(* return false if formula 'c1' negates 'c2' (or vice versa), otherwise true *)
					match c1, c2 with
					| Eq (r1, v1), Eq (r2, v2) -> if r1 = r2 then not (v1 = v2) else false
					| Eq (r1, v1), Ne (r2, v2) -> if r1 = r2 then v1 = v2 else false
					| Ne (r1, v1), Eq (r2, v2) -> if r1 = r2 then v1 = v2 else false
					| _                        -> false
				) tail then False
			else if List.mem c1 tail then iter tail acc
			else iter tail (c1 :: acc)
	in
	match c with
	| And clauses -> iter clauses []
	| _           -> error 510

(**
 * simplify a disjunction formula
 * - remove duplications
 *)
and simplify_disjunction c =
	let rec iter clauses acc =
		match clauses with
		| [] -> Or acc
		| c1 :: tail ->
			if List.mem c1 tail then iter tail acc
			else iter tail (c1 :: acc)
	in
	match c with
	| Or clauses -> iter clauses []
	| _          -> error 511

(**
 * cross product of disjunction clauses of a conjunction formula
 * @param ands conjunction clauses of the formula
 * @param ors  disjunction clauses of the formula
 *)
and cross_product_of_conjunction ands ors =
	let cross cs1 cs2 =
		List.fold_left (fun acc1 c1 ->
			List.fold_left (fun acc2 c2 -> (And [c1; c2]) :: acc2) acc1 cs2
		) [] cs1
	in
	let merge_ands =
		List.fold_left (fun acc c ->
			match c with
			| And css -> (simplify_conjunction (And (List.append css ands))) :: acc
			| _       -> error 512
		) []
	in
	let rec iter cs =
		match cs with
		| []                           -> []
		| (Or cs) :: []                -> merge_ands cs
		| (Or cs1) :: (Or cs2) :: tail -> iter ((Or (cross cs1 cs2)) :: tail)
		| _                            -> error 513
	in
	dnf_of (Or (iter ors))

(** convert a constraint to DNF **)
and dnf_of c (vars: Variable.ts) env =
	match c with
	| Eq (r, v)      -> dnf_of_equal r v vars env
	| Ne (r, v)      -> dnf_of_not_equal r v vars env
	| Not c1         -> dnf_of_negation c1 vars env
	| Imply (c1, c2) -> dnf_of_implication c1 c2 vars env
	| In (r, vec)    -> dnf_of_membership r vec vars env
	| And cs         -> dnf_of_conjunction cs vars env
	| Or cs          -> dnf_of_disjunction cs vars env
	| Greater (r, v) -> dnf_of_numeric r v vars env (fun x1 x2 -> x1 > x2)
	| GreaterEqual (r, v) -> dnf_of_numeric r v vars env (fun x1 x2 -> x1 >= x2)
	| Less (r, v) -> dnf_of_numeric r v vars env (fun x1 x2 -> x1 < x2)
	| LessEqual (r, v) -> dnf_of_numeric r v vars env (fun x1 x2 -> x1 <= x2)
	| _              -> error 550

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
	) else dnf_of (compile_nested r v vars env 5) vars env

(** convert equality to DNF, and convert a left-nested reference to prevail ones **)
and dnf_of_equal r v vars env =
	if Variable.mem r vars then Eq (r, v)
	else dnf_of (compile_nested r v vars env 1) vars env

(** convert inequality to DNF, and convert a left-nested reference to prevail ones **)
and dnf_of_not_equal r v vars env =
	if Variable.mem r vars then
		let values =
			Array.fold_left (
				fun acc v1 ->
					match v1 with
					| Basic v2 -> if v2 = v then acc else v2 :: acc
					| _        -> error 514 (* the right-hand side is not a basic value *)
			) [] (Variable.values_of r vars)
		in
		if values = [] then False
		else dnf_of (In (r, values)) vars env

	else
		dnf_of (compile_nested r v vars env 2) vars env

(** convert negation to DNF **)
and dnf_of_negation c vars env =
	match c with
	| True      -> False
	| False     -> True
	| Eq (r, v) -> dnf_of (Ne (r, v)) vars env
	| Ne (r, v) -> dnf_of (Eq (r, v)) vars env
	| Greater (r, v) -> dnf_of (LessEqual (r, v)) vars env
	| GreaterEqual (r, v) -> dnf_of (Less (r, v)) vars env
	| Less (r, v) -> dnf_of (GreaterEqual (r, v)) vars env
	| LessEqual (r, v) -> dnf_of (Greater (r, v)) vars env
	| Not c1    -> dnf_of c1 vars env
	| Imply (premise, conclusion) ->
		dnf_of (And [premise; (Not conclusion)]) vars env                (* -(p -> q) = p ^ -q *)
	| And cs ->
		let cs1 = List.fold_left (fun acc c -> (Not c) :: acc) [] cs in  (* De Morgan's laws *)
		dnf_of (Or cs1) vars env
	| Or cs  ->
		let cs1 = List.fold_left (fun acc c -> (Not c) :: acc) [] cs in  (* De Morgan's laws *)
		dnf_of (And cs1) vars env
	| In (r, vec) ->
		if Variable.mem r vars then
			let cs = Array.fold_left (
					fun acc v ->
						match v with
						| Basic v1 ->
							if List.mem v1 vec then acc
							else (Eq (r, v1)) :: acc
						| _        -> error 515
				) [] (Variable.values_of r vars)
			in
			if cs = [] then False
			else dnf_of (Or cs) vars env
		else
			dnf_of (compile_nested r (Vector vec) vars env 4) vars env

(** convert implication to DNF **)
and dnf_of_implication premise conclusion vars env =
	dnf_of (Or [(Not premise); conclusion]) vars env

(** convert membership constraint to DNF **)
and dnf_of_membership r vec vars env =
	if Variable.mem r vars then
		let cs = Array.fold_left (
				fun acc v ->
					match v with
					| Basic v1 ->
						if List.mem v1 vec then (Eq (r, v1)) :: acc
						else acc
					| _        -> error 516
			) [] (Variable.values_of r vars)
		in
		if cs = [] then False
		else dnf_of (Or cs) vars env
	else
		dnf_of (compile_nested r (Vector vec) vars env 3) vars env

(** convert conjunction to DNF, performs cross-products when it has disjunction clause **)
and dnf_of_conjunction cs vars env =
	let rec iter clauses ands ors =
		if clauses = [] then (false, ands, ors)
		else
			match dnf_of (List.hd clauses) vars env with
			| And css -> iter (List.tl clauses) (List.append css ands) ors
			| False   -> (true, ands, ors)
			| True    -> iter (List.tl clauses) ands ors
			| Or css  -> iter (List.tl clauses) ands ((Or css) :: ors)
			| css     -> iter (List.tl clauses) (css :: ands) ors
	in
	let (all_false, ands, ors) = iter cs [] [] in
	if all_false then False
	else
		match ands, ors with
		| [], [] -> True
		| head :: [], [] -> head
		| [], head :: [] -> head
		| _, []          -> simplify_conjunction (And ands)
		| _, _           -> (cross_product_of_conjunction ands ors) vars env

(** convert disjunction to DNF **)
and dnf_of_disjunction cs vars env =
	let rec iter clauses acc =
		if clauses = [] then (false, acc)
		else
			match dnf_of (List.hd clauses) vars env with
			| Or cs -> iter (List.tl clauses) (List.append cs acc)
			| False -> iter (List.tl clauses) acc
			| True  -> (true, acc)
			| c     -> iter (List.tl clauses) (c :: acc)
	in
	let (all_true, cs1) = iter cs [] in
	if all_true then True
	else if (List.tl cs1) = [] then List.hd cs1
	else simplify_disjunction (Or cs1)
	;;

(* substitute each parameter with a value as specified in the parameters table *)
let rec substitute_parameters_of (c: _constraint) params =
	match c with
	| Eq (r, v) ->
		let r1 = substitute_parameter_of_reference r params in
		let v1 = substitute_parameter_of_basic_value v params in
		Eq (r1, v1)
	| Ne (r, v) ->
		let r1 = substitute_parameter_of_reference r params in
		let v1 = substitute_parameter_of_basic_value v params in
		Ne (r1, v1)
	| Not c          -> Not (substitute_parameters_of c params)
	| Imply (c1, c2) -> Imply (substitute_parameters_of c1 params, substitute_parameters_of c2 params)
	| And cs         -> And (List.fold_left (fun css c -> (substitute_parameters_of c params) :: css) [] cs)
	| Or cs          -> Or (List.fold_left (fun css c -> (substitute_parameters_of c params) :: css) [] cs)
	| In (r, v)      -> let r1 = substitute_parameter_of_reference r params in In (r1, v)
	| _              -> c
	;;


(************************************************************************
 * Functions for global constraints.
 ************************************************************************)

type data =
	{
		complex  : _constraint list;
		simple   : _constraint list;
		variables: Variable.ts
	}

(** compile simple membership of global constraints **)
let compile_simple_global_membership (is_negation: bool) (r: reference) (vec: vector) (dat: data) : data =
	let rec prevail_of rx =
		if rx = [] then error 507
		else if Variable.mem rx dat.variables then rx
		else prevail_of (prefix rx)
	in
	let prevail = prevail_of r in
	if prevail = r then
		{
			complex   = dat.complex;
			simple    = dat.simple;
			variables = if is_negation then Variable.remove_values_from r vec dat.variables
			            else Variable.intersection_with_values r vec dat.variables
		}
	else
		let vars1 = Variable.remove_value_from prevail (Basic Null) dat.variables in
		let rs = r @-- prevail in
		Array.fold_left (fun acc v1 ->
				match v1 with
				| Basic (Ref r1) ->
					let r2 = r1 @++ rs in
					let c =
						if is_negation then Imply (Eq (prevail, Ref r1), Not (In (r2, vec)))
						else Imply (Eq (prevail, Ref r1), In (r2, vec))
					in
					{ complex = c :: acc.complex; simple = acc.simple; variables = acc.variables }
				| _ -> error 508
			)
			{ complex = dat.complex; simple = dat.simple; variables = vars1 }
			(Variable.values_of prevail vars1)

(** compile simple equality of global constraints **)
let compile_simple_global_equality (is_negation: bool) (r: reference) (v: basic) (dat: data) : data =
	let rec prevail_of rx =
		if rx = [] then error 509
		else if Variable.mem rx dat.variables then rx
		else prevail_of (prefix rx)
	in
	let prevail = prevail_of r in
	if prevail = r then
		{
			complex   = dat.complex;
			simple    = dat.simple;
			variables = if is_negation then Variable.remove_value_from r (Basic v) dat.variables
			            else Variable.intersection_with_value r (Basic v) dat.variables
		}
	else 
		let vars1 = Variable.remove_value_from prevail (Basic Null) dat.variables in
		let rs = r @-- prevail in
		Array.fold_left (fun acc v1 ->
				match v1 with
				| Basic (Ref r1) ->
					let r2 = r1 @++ rs in
					let c =
						if is_negation then Imply (Eq (prevail, Ref r1), Ne (r2, v))
						else Imply (Eq (prevail, Ref r1), Eq (r2, v))
					in
					if not is_negation && (Variable.mem r2 acc.variables) then
						{ complex = acc.complex; simple = c :: acc.simple; variables = acc.variables }
					else
						{ complex = c :: acc.complex; simple = acc.simple; variables = acc.variables }
				| _ -> error 510
			)
			{ complex = dat.complex; simple = dat.simple; variables = vars1 }
			(Variable.values_of prevail vars1)

(** compile simple equality and membership of global constraints **)
let compile_simple_global (global: _constraint) (vars: Variable.ts) =
	match global with
	| And cs ->
		let result1 = List.fold_left (fun acc c ->
				match c with
				| Eq (r, v)         -> compile_simple_global_equality false r v acc
				| Not (Eq (r, v))   -> compile_simple_global_equality true r v acc
				| Ne (r, v)         -> compile_simple_global_equality true r v acc
				| Not (Ne (r, v))   -> compile_simple_global_equality false r v acc
				| In (r, vec)       -> compile_simple_global_membership false r vec acc
				| Not (In (r, vec)) -> compile_simple_global_membership true r vec acc
				| Imply (Eq (_, _), Eq (_, _)) ->
					{
						complex = acc.complex;
						simple = c :: acc.simple;
						variables = acc.variables
					}
				| Imply (Eq (r, v), And cs) -> (
						let eq = Eq (r, v) in
						List.fold_left (fun (acc: data) (c: _constraint) ->
							match c with
							| Eq (_, _) ->
								{
									complex = acc.complex;
									simple = (Imply (eq, c)) :: acc.simple;
									variables = acc.variables
								}
							| _ ->
								{
									complex = (Imply (eq, c)) :: acc.complex;
									simple = acc.simple;
									variables = acc.variables
								}
						) acc cs
					)
				| _ ->
					{
						complex = c :: acc.complex;
						simple = acc.simple;
						variables = acc.variables
					}
			) { complex = []; simple = []; variables = vars } cs
		in
		(And result1.complex, result1.simple, result1.variables)
	| _  -> (global, [], vars)

(**
 * Find the global constraints element in a flat-store. If exist, then convert
 * and return a DNF of the global constraints
 *)
let global_of (env: Type.env) (fs: Domain.flatstore) (vars: Variable.ts) : (_constraint * _constraint list * Variable.ts) =
	let r = ["global"] in
	if MapRef.mem r fs then
		match MapRef.find r fs with
		| Global g ->
			let (global1, implies1, vars1) = compile_simple_global g vars in
			let global_dnf = dnf_of global1 vars1 env in
			(global_dnf, implies1, vars1)
			(* (dnf_of g vars env, [], vars) *)
		| _        -> error 519
	else (True, [], vars)
