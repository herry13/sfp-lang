open Common

(*******************************************************************
 * semantics primary and secondary domains
 *******************************************************************)
(** core elements **)
type vector   = basic list
and basic     = Boolean of bool
              | Int of int
              | Float of float
              | String of string
              | Null
              | Vector of vector
              | Ref of reference
and value     = Basic of basic
              | Store of store
              | Global of _constraint
              | Link of reference
              | Action of action
              | TBD
              | Unknown
              | Nothing
and _value    = Val of value
              | Undefined
and cell      = ident * value
and store     = cell list
and reference = ident list
and ident     = string

(** constraint elements **)
and _constraint = Eq of reference * basic
                | Ne of reference * basic
				| Greater of reference * basic
				| GreaterEqual of reference * basic
				| Less of reference * basic
				| LessEqual of reference * basic
                | Not of _constraint
                | Imply of _constraint * _constraint
                | And of _constraint list
                | Or of _constraint list
                | In of reference * vector
                | True
                | False

(** action elements **)
and action         = reference * parameter_type list * int * _constraint *
                     effect list
and parameter_type = ident * Syntax._type
and cost           = int
and effect         = reference * basic

(*******************************************************************
 * helpers
 *******************************************************************)

(** exception for any error on semantics algebra **)
exception SfError of int * string

(**
 * receive and print semantics error message
 * @code int error code
 *)
let error code message =
	if message = "" then
		raise (SfError (code, "[err" ^ (string_of_int code) ^ "]"))
	else
		raise (SfError (code, "[err" ^ (string_of_int code) ^ "] " ^
			message)) ;;

(*******************************************************************
 * semantics algebras
 *******************************************************************)

(* identifier and reference functions *)

let (!^) r = String.concat "." r

let rec prefix reference =
	match reference with
	| []           -> []
	| head :: tail -> if tail = [] then []
	                  else head :: (prefix tail)
;;

let (!-) reference = prefix reference ;;

let ref_plus_ref reference1 reference2 = List.append reference1 reference2 ;;

let (@++) reference1 reference2 = ref_plus_ref reference1 reference2 ;;

let ref_plus_id reference identifier = ref_plus_ref reference [identifier] ;;

let (@+.) reference identifier = ref_plus_id reference identifier ;;

let rec ref_minus_ref reference1 reference2 =
	if reference1 = [] then []
	else if reference2 = [] then reference1
	else if (List.hd reference1) = (List.hd reference2)
		then ref_minus_ref (List.tl reference1) (List.tl reference2)
	else reference1
;;

let (@--) reference1 reference2 = ref_minus_ref reference1 reference2 ;;

let ref_prefixeq_ref reference1 reference2 =
	(reference1 @-- reference2) = [] ;;

let (@<=) reference1 reference2 = ref_prefixeq_ref reference1 reference2 ;;

let ref_prefix_ref reference1 reference2 =
	((ref_prefixeq_ref reference1 reference2) &&
		not (reference1 = reference2)) ;;

let (@<) reference1 reference2 = ref_prefix_ref reference1 reference2 ;;

let rec trace baseReference reference =
	match reference with
	| [] -> baseReference
	| "this" :: rs -> trace baseReference rs
	| "root" :: rs -> trace [] rs
	| "parent" :: rs ->
		if baseReference = [] then
			error 501 ("invalid reference " ^ !^reference)
		else
			trace (prefix baseReference) rs
	| id :: rs -> trace (baseReference @+. id) rs
;;

let (@<<) baseReference reference = trace baseReference reference ;;

let simplify reference = trace [] reference ;;

let (!!) reference = simplify reference ;;


(** store functions **)

let rec find store reference : _value =
	match (store, reference) with
	| _, []                      -> Val (Store store)
	| [], _                      -> Undefined
	| (ids,vs) :: tail, id :: rs ->
		if ids = id then
			if rs = [] then Val vs
			else
				match vs with
				| Store child -> find child rs
				| _           -> Undefined
		else find tail reference
;;

(**
 * TODOC
 * unlike 'find', function 'find_follow' can resolve a nested reference
 *)
let find_follow store reference : _value =
	let rec search s r : _value =
		match (s, r) with
		| _, [] -> Val (Store s)
		| [], _ -> Undefined
		| (ids, vs) :: tail, id :: rs ->
			if ids = id then
				if rs = [] then Val vs
				else
					match vs with
					| Store child -> search child rs
					| Basic (Ref r) -> search store (r @++ rs)
					| _ -> Undefined
			else search tail r
	in
	search store reference

let rec resolve store baseReference reference =
	match reference with
	| "root" :: rs   -> ([], find store !!rs)
	| "parent" :: rs ->
		if baseReference = [] then
			error 502 ("invalid reference " ^ !^reference)
		else (
			prefix baseReference,
			find store !!((prefix baseReference) @++ rs)
		)
	| "this" :: rs   -> (baseReference, find store !!(baseReference @++ rs))
	| _              ->
		if baseReference = [] then ([], find store !!reference)
		else
			let value = find store (baseReference @<< reference) in
			match value with
			| Undefined -> resolve store (prefix baseReference) reference
			| _         -> (baseReference, value)
;;

let rec get_link store baseReference reference linkReference accumulator =
	let (baseRef, ref) =
		match linkReference with
		| "root" :: rs -> ([], rs)
		| "parent" :: rs ->
			if baseReference = [] then
				error 515 ("invalid link-reference " ^ !^linkReference)
			else
				([], (prefix baseReference) @++ rs)
		| "this" :: rs -> ([], baseReference @++ rs)
		| _ -> (baseReference, linkReference)
	in
	if SetRef.exists (fun r -> r = ref) accumulator then
		error 503 ("cyclic link-reference " ^ !^ref)
	else
		match (resolve store baseRef ref) with
		| nsp, value -> (
				let r = nsp @++ ref in
				match value with
				| Val (Link lr) -> get_link store (prefix r) reference lr
				                       (SetRef.add r accumulator)
				| _ -> if r @<= reference then
				           error 504 ("implicit cyclic link-reference " ^ !^r)
				       else
				           (r, value)
			)
;;

let resolve_link store baseReference reference linkReference =
	match linkReference with
	| Link lr -> get_link store baseReference reference lr SetRef.empty
	| _       -> error 505 "invalid link reference"
;;

let rec put store identifier value =
	match store with
	| []              -> (identifier, value) :: []
	| (id, v) :: tail ->
		if id = identifier then
			match v, value with (* merge semantics?? *)
			| Store destination, Store source ->
				(identifier, Store (copy destination source [])) :: tail
			| _,_ -> (identifier, value) :: tail
		else
			(id, v) :: put tail identifier value

and copy destination source prefix =
	match source with
	| []              -> destination
	| (id, v) :: tail -> copy (bind destination (prefix @+. id) v) tail prefix

and bind store reference value =
	match reference with
	| []       -> error 506 "invalid reference"
	| id :: rs ->
		if rs = [] then put store id value
		else
			match store with
			| []               -> error 507 "invalid reference"
			| (ids, vs) :: tail ->
				if ids = id then
					match vs with
					| Store child -> (id, Store (bind child rs value)) :: tail
					| _           -> error 508 "invalid reference"
				else
					(ids,vs) :: bind tail reference value
;;

let inherit_proto store baseReference prototypeReference reference =
	match resolve store baseReference prototypeReference with
	| _, Val (Store s) -> copy store s reference
	| _, Val (Link lr) -> (
			match resolve_link store baseReference reference (Link lr) with
			| _, Val (Store s) -> copy store s reference
			| _, _             -> error 509 ""
		)
	| _, _             -> error 510 ""
;;

let rec replace_link store baseReference identifier value baseReference1 =
	let rp = baseReference @+. identifier in
	match value with
	| Link rl  -> (
			match resolve_link store baseReference1 rp (Link rl) with
			| _, Undefined -> error 511 ""
			| nsp, Val vp  -> (
					let sp = bind store rp vp in
					match vp with
					| Store ssp -> accept sp rp ssp nsp
					| _         -> sp
				)
		)
	| Store vs -> accept store rp vs rp
	| _        -> store
		
and accept store baseReference store1 baseReference1 =
	match store1 with
	| []      -> store
	| (id, v) :: sp ->
		let sq = replace_link store baseReference id v baseReference1 in
		accept sq baseReference sp baseReference1
;;

let rec value_TBD_exists store =
	match store with
	| []            -> false
	| (id, v) :: ss ->
		match v with
		| TBD      -> true
		| Store sp -> if value_TBD_exists sp then true
		              else value_TBD_exists ss
		| _        -> value_TBD_exists ss
;;


(*******************************************************************
 * convert reference (list of string) to string
 *******************************************************************)

let (!^) reference = "$." ^ String.concat "." reference ;;

let string_of_ref reference = !^reference ;;


(*******************************************************************
 * convert JSON to the semantics domain
 *******************************************************************)

let rec from_json store =
	let reference_separator = Str.regexp "\\." in
	let rec make_vector acc vec =
		match vec with
		| []           -> acc
		| head :: tail -> (
				match sfp_of head with
				| Basic bv -> (make_vector (bv :: acc) tail)
				| _        -> error 512 ""
			)
	and make_store acc s =
		match s with
		| []              -> acc
		| (id, v) :: tail -> make_store ((id, (sfp_of v)) :: acc) tail
	and sfp_of = function
		| `String str
			when (String.length str) > 2 && str.[0] = '$' && str.[1] = '.' ->
				Basic (Ref (List.tl (Str.split reference_separator str)))
		| `String str -> Basic (String str)
		| `Bool b     -> Basic (Boolean b)
		| `Float f    -> Basic (Float f)
		| `Int i      -> Basic (Int i)
		| `Null       -> Basic Null
		| `List vec   -> Basic (Vector (make_vector [] vec))
		| `Assoc s    -> Store (make_store [] s)
	in
	sfp_of (Yojson.Basic.from_string store)
;;


(*******************************************************************
 * convert the semantics domains to JSON
 *******************************************************************)

let rec json_of_store store = "{" ^ (json_of_store1 store) ^ "}"

and json_of_store1 = function
	| []                -> ""
	| (ids, vs) :: []   -> json_of_cell ids vs
	| (ids, vs) :: tail -> (json_of_cell ids vs) ^ "," ^ json_of_store1 tail

and json_of_cell id v = "\"" ^ id ^ "\":" ^ (json_of_value v)

and json_of_value = function
	| Link lr       -> "\"link " ^ !^lr ^ "\""
	| Basic basic   -> json_of_basic basic
	| Store child   -> "{" ^ json_of_store1 child ^ "}"
	| Global global -> json_of_constraint global
	| Action action -> json_of_action action
	| TBD           -> "\"§TBD\""
	| Unknown       -> "\"§unknown\""
	| Nothing       -> "\"§nothing\""

and json_of_basic = function
	| Boolean b  -> string_of_bool b
	| Int i      -> string_of_int i
	| Float f    -> string_of_float f
	| String s   ->  "\"" ^ s ^ "\""
	| Null       -> "null"
	| Vector vec -> "[" ^ (json_of_vec vec) ^ "]"
	| Ref r      -> "\"" ^ !^r ^ "\""

and json_of_vec = function
	| []           -> ""
	| head :: tail ->
		let h = json_of_basic head in
		if tail = [] then h else h ^ "," ^ (json_of_vec tail)

(** convert a constraint to JSON **)
and json_of_constraint = function
	| Eq (r, bv) -> "[\"=\",\"" ^ !^r ^ "\"," ^ (json_of_basic bv) ^ "]"
	| Ne (r, bv) -> "[\"!=\",\"" ^ !^r ^ "\"," ^ (json_of_basic bv) ^ "]"
	| Greater (r, bv) -> "[\">\",\"" ^ !^r ^ "\"," ^ (json_of_basic bv) ^ "]"
	| GreaterEqual (r, bv) ->
		"[\">=\",\"" ^ !^r ^ "\"," ^ (json_of_basic bv) ^ "]"
	| Less (r, bv) -> "[\"<\",\"" ^ !^r ^ "\"," ^ (json_of_basic bv) ^ "]"
	| LessEqual (r, bv) ->
		"[\"<=\",\"" ^ !^r ^ "\"," ^ (json_of_basic bv) ^ "]"
	| Not c -> "[\"not\"," ^ (json_of_constraint c) ^ "]"
	| Imply (c1, c2)  ->
		"[\"imply\"," ^ (json_of_constraint c1) ^ "," ^
			(json_of_constraint c2) ^ "]"
	| And cs          ->
		(List.fold_left (
			fun s c -> s ^ "," ^ (json_of_constraint c)
		) "[\"and\"" cs) ^ "]"
	| Or cs           ->
		(List.fold_left (
			fun s c -> s ^ "," ^ (json_of_constraint c)
		) "[\"or\"" cs) ^ "]"
	| In (r, vec)     -> "[\"in\",\"" ^ !^r ^ "\",[" ^ (json_of_vec vec) ^ "]]"
	| True            -> "true"
	| False           -> "false"
	

(** convert an action to JSON **)
and json_of_effect (r, bv) =
	"[\"=\",\"" ^ !^r ^ "\"," ^ (json_of_basic bv) ^ "]"

and json_of_effects effs =
	(List.fold_left (
		fun acc e -> acc ^ "," ^ (json_of_effect e)
	) "[\"effects\"" effs) ^ "]"

and json_of_conditions cond =
	"[\"conditions\"," ^ (json_of_constraint cond) ^ "]"

and json_of_cost cost = "[\"cost\"," ^ (string_of_int cost) ^ "]"

and json_of_parameter (id, t) =
	"[\"" ^ id ^ "\",\"" ^ (Syntax.string_of_type t) ^ "\"]"

and json_of_parameters params =
	(List.fold_left (
		fun acc p -> acc ^ "," ^ (json_of_parameter p)
	) "[\"parameters\"" params) ^ "]"

and json_of_action (name, params, cost, conds, effs) =
	"[\"" ^ !^name ^ "\"," ^ (json_of_parameters params) ^ "," ^
	(json_of_conditions conds) ^ "," ^ (json_of_effects effs) ^ "]"
;;


(*******************************************************************
 * convert the semantics domain to YAML
 *******************************************************************)
let rec yaml_of_store store = yaml_of_store1 store ""

and yaml_of_store1 store tab =
	match store with
	| []                -> "{}"
	| (ids, vs) :: []   -> yaml_of_cell ids vs tab
	| (ids, vs) :: tail ->
		(yaml_of_cell ids vs tab) ^ "\n" ^ (yaml_of_store1 tail tab)

and yaml_of_cell identifier value tab =
	let _name = tab ^ identifier ^ ": " in
	let _value =
		match value with
		| Link lr       -> "link " ^ !^lr
		| Basic basic   -> yaml_of_basic basic
		| Store []      -> yaml_of_store1 [] (tab ^ "  ")
		| Store child   -> "\n" ^ yaml_of_store1 child (tab ^ "  ")
		| Global global -> yaml_of_constraint global (tab ^ "  ")
		| Action action -> yaml_of_action action (tab ^ "  ")
		| TBD           -> "§TBD"
		| Unknown       -> "§unknown"
		| Nothing       -> "§nothing"
	in
	_name ^ _value

and yaml_of_vec = function
	| []           -> ""
	| head :: tail ->
		let v = yaml_of_basic head in
		if tail = [] then v
		else v ^ "," ^ (yaml_of_vec tail)

and yaml_of_basic = function
	| Boolean b  -> string_of_bool b
	| Int i      -> string_of_int i
	| Float f    -> string_of_float f
	| String s   -> s
	| Null       -> "null"
	| Vector vec -> "[" ^ (yaml_of_vec vec) ^ "]"
	| Ref r      -> !^r

(** convert a constraint to YAML **)
and yaml_of_constraint c tab = json_of_constraint c

(** convert an action to YAML **)
and yaml_of_action (name, params, cost, conds, effs) tab =
	"\n" ^
	tab ^ "name: " ^ !^name ^ "\n" ^
	tab ^ "parameters: " ^ (yaml_of_parameters params (tab ^ "  ")) ^ "\n" ^
	tab ^ "cost: " ^ (string_of_int cost) ^ "\n" ^
	tab ^ "conditions: " ^ (yaml_of_constraint conds (tab ^ "  ")) ^ "\n" ^
	tab ^ "effects: " ^ (yaml_of_effects effs (tab ^ "  "))

and yaml_of_parameters params tab =
	List.fold_left (
		fun acc p -> acc ^ "\n" ^ (yaml_of_parameter p tab)
	) "" params

and yaml_of_parameter (id, t) tab = tab ^ id ^ ": " ^ (Syntax.string_of_type t)

and yaml_of_effects effs tab =
	List.fold_left (
		fun acc eff -> acc ^ "\n" ^ (yaml_of_effect eff tab)
	) "" effs

and yaml_of_effect (r, bv) tab = tab ^ !^r ^ ": " ^ (json_of_basic bv)
;;


(*******************************************************************
 * Flat-Store domain
 *******************************************************************)

type flatstore = value MapRef.t

let static_object = Store [] ;;

let normalise store =
	let rec visit store baseReference flatstore =
		match store with
		| [] -> flatstore
		| (id, v) :: tail ->
			let r = baseReference @+. id in
			let fss =
				match v with
				| Store child ->
					visit child r (MapRef.add r static_object flatstore)
				| Action (_, ps, c, pre, post) ->
					MapRef.add r (Action (r, ps, c, pre, post)) flatstore
				| _ -> 
					MapRef.add r v flatstore
			in
			visit tail baseReference fss
	in
	visit store [] MapRef.empty
;;

let string_of_flatstore flatstore =
	MapRef.fold (
		fun r v acc -> acc ^ !^r ^ ": " ^ (json_of_value v) ^ "\n"
	) flatstore ""
;;


(*******************************************************************
 * set of values
 *******************************************************************)

module SetValue = Set.Make (
	struct
		type t = value
		let compare = Pervasives.compare
	end
)

let string_of_setvalue setValue =
	SetValue.fold (
		fun v s -> s ^ (json_of_value v) ^ ";"
	) setValue ""
;;


(*******************************************************************
 * parameters
 *******************************************************************)

type ground_parameters = basic MapStr.t

(**
 * substitute each left-hand side reference with a reference as
 * specified in the parameters table
 *)
let substitute_parameter_of_reference reference groundParameters =
	match reference with
	| id :: tail ->
		if MapStr.mem id groundParameters then
			match MapStr.find id groundParameters with
			| Ref r1 -> r1 @++ tail
			| _      -> error 513 ("cannot replace left-hand side " ^
				"reference with a non-reference value")
			            (* cannot replace left-hand side reference with
						   a non-reference value *)
		else reference
	| _ -> reference

(**
 * substitute each right-hand side reference of basic value
 * with a value as specified in the parameters table
 *)
let substitute_parameter_of_basic_value basicValue groundParameters =
	match basicValue with
	| Ref (id :: tail) ->
		if MapStr.mem id groundParameters then
			match MapStr.find id groundParameters with
			| Ref r1            -> Ref (r1 @++ tail)
			| v1 when tail = [] -> v1
			| _                 -> error 514 ""
		else basicValue
	| _ -> basicValue

