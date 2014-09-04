open Common
open Syntax

(**
 * This module performs static type checking of given SFP specifications.
 *
 * Any part with TODOC requires to be documented.
 *)

(*******************************************************************
 * type environment
 *******************************************************************)

type map        = _type MapRef.t

type _t         = Type of _type
                | Undefined
and var         = string list * _type
and environment = var list
(*and lenv = environment*)

(*******************************************************************
 * helper functions
 *******************************************************************)

let rec (@==) reference1 reference2 =
	match reference1, reference2 with
	| [], []                                -> true
	| id1 :: rs1, id2 :: rs2 when id1 = id2 -> rs1 @== rs2
	| _                                     -> false

(* alias of functions from module Domain *)
let (@++)  = Domain.(@++);;
let (@--)  = Domain.(@--);;
let prefix = Domain.prefix;;
let (@<=)  = Domain.(@<=);;
let (@<)   = Domain.(@<);;
let (!!)   = Domain.(!!);;
let (@<<)  = Domain.(@<<);;
let (!^)   = Domain.(!^);;

exception TypeError of int * string

let error code message =
	raise (TypeError (code, "[type-err" ^ string_of_int(code) ^ "] " ^
		message))
;;

let string_of_map map =
	MapRef.fold (
		fun r t s -> s ^ (!^r) ^ " : " ^ (string_of_type t) ^ "\n"
	) map ""
;;

(** convert a type environment to a map **)
let map_of environment =
	List.fold_left (
		fun acc (r, t) -> MapRef.add r t acc
	) MapRef.empty environment
;;

let type_of reference map =
	if MapRef.mem reference map then MapRef.find reference map
	else TUndefined
;;

(*******************************************************************
 * typing judgement functions
 *******************************************************************)

(** return the type of variable 'reference' **)
let rec find typeEnv reference =
	match typeEnv with
	| []             -> Undefined
	| (r, t) :: tail -> if reference = r then Type t
	                    else find tail reference
;;

(** return true if variable 'reference' is defined in the environment,
    otherwise false *)
let rec domain typeEnv reference =
	match typeEnv with
	| []             -> false
	| (r, _) :: tail -> if reference = r then true
	                    else (domain tail reference)
;;

(**
 * Subtyping rules
 * return true if type 'type1' is a sub-type of 'type2', otherwise false
 *)
let rec (<:) type1 type2 =
	if type1 = type2 then true (* (Reflex) *)
	else
		match type1, type2 with
		| TAny, _ when type2 <> TUndefined     -> true
		                                          (* TODOC (Any Subtype) *)
		| TBasic TInt, TBasic TFloat           -> true (* TODOC (IntFloat) *)
		| TBasic (TSchema _), TBasic TObject   -> true (* (Object Subtype) *)
		| TBasic (TSchema (sid1, super1)), _   -> TBasic super1 <: type2
		                                          (* (Trans) *)
		| TVec t1, TVec t2                     -> t1 <: t2 (* (Vec Subtype) *)
		| TRef t1, TRef t2                     -> TBasic t1 <: TBasic t2
		                                          (* (Ref Subtype) *)
		| TBasic TNull, TRef _                 -> true (* (Ref Null) *)
		| _, _                                 -> false
;;

let subtype type1 type2 = type1 <: type2 ;;

(*******************************************************************
 * well-formed environments and types functions
 *******************************************************************)

(* return true if '_type' is defined in the environment, otherwise false *)
let rec has_type typeEnv _type =
	match _type with
	| TUndefined                -> false (* _type is not defined *)
	| TAny                      -> true  (* TODOC (Type Any) *)
	| TForward (_, _)           -> true  (* TODOC (Type Forward) *)
	| TVec t                    -> has_type typeEnv t    (* (Type Vec)    *)
	| TRef t                    -> has_type typeEnv (TBasic t) (* (Type Ref) *)
	| TBasic TBool              -> true                  (* (Type Bool)   *)
	| TBasic TInt               -> true                  (* (Type Int)    *)
	| TBasic TFloat             -> true                  (* (Type Flaot)  *)
	| TBasic TStr               -> true                  (* (Type Str)    *)
	| TBasic TNull              -> true                  (* (Type Null)   *)
	| TBasic TObject            -> true                  (* (Type Object) *)
	| TBasic TAction            -> true                  (* (Type Action) *)
	| TBasic TGlobal            -> true                  (* (Type Global) *)
	| TBasic TRootSchema        -> true
	| TBasic (TSchema (sid, _)) ->
		match typeEnv with
		| [] -> false
		| (_, (TBasic (TSchema (side, _)))) :: tail ->
			if sid = side then true  (* (Type Schema) *)
			else has_type tail _type
		| (_, _) :: tail -> has_type tail _type
;;

let is_well_typed typeEnv =
	let rec iter e typeEnv =
		match e with
		| []             -> true
		| (r, t) :: tail ->
			if (has_type typeEnv t) then iter tail typeEnv
			else false
	in
	iter typeEnv typeEnv
;;

let is_schema _type = _type <: (TBasic TRootSchema) ;;

let rec object_of_schema basicType =
	match basicType with
	| TSchema (sid, TRootSchema) -> TSchema (sid, TObject)
	| TSchema (sid, super) -> TSchema (sid, object_of_schema super)
	| _  -> error 401 "cannot create type object of a non-schema type"
;;

(*******************************************************************
 * type assignment functions
 *******************************************************************)

(* bind _'type' to variable 'reference' *)
let bind typeEnv reference _type =
	match (find typeEnv reference), reference with
	| Undefined, []       -> error 402 "empty reference"
	| Undefined, id :: [] -> (reference, _type) :: typeEnv
	| Undefined, _ -> (
			match find typeEnv (prefix reference) with
			| Undefined ->
				error 403 ("prefix of " ^ !^reference ^ " is not defined")
			| Type t when t <: TBasic TObject ->
				(reference, _type) :: typeEnv
			| _ ->
				error 404 ("prefix of " ^ !^reference ^ " is not a component")
		)
	| _, _ -> error 405 ("cannot bind type to an existing variable " ^
	              !^reference)
;;

(**
 * @param typeEnv       type environment
 * @param reference     reference of the variable
 * @param _type         pre-defined type
 * @param typeValue     type of value which will be assigned
 *)
let assign typeEnv reference _type typeValue =
	match (find typeEnv reference), _type, typeValue with
	| Undefined, TUndefined, TAny ->
		error 405 (!^reference ^
			" cannot assign Any to an undefined variable")
	| Undefined, TUndefined, _ ->  (* (Assign1) *)
		bind typeEnv reference typeValue
	| Undefined, _, _ when typeValue <: _type ->  (* (Assign3) *)
		bind typeEnv reference _type
	| Type (TForward (_, _)), _, _      (* TODOC *)
	| Undefined, _, TForward (_, _) ->  (* TODOC (Assign5) *)
		(reference, _type) :: (reference, typeValue) :: typeEnv
	| Undefined, _, _ ->
		error 406 (!^reference ^ " not satisfy rule (Assign3)")
	| Type typeVar, TUndefined, _ when typeValue <: typeVar ->
		(* (Assign2) *)
		typeEnv                                         
	| Type typeVar, TUndefined, TForward (_, _) ->
		(* TODOC (Assign6) *)
		(reference, typeValue) :: typeEnv
	| Type _, TUndefined, _ ->
		error 407 (!^reference ^ " not satisfy rule (Assign2)")
	| Type typeVar, _, _ when (typeValue <: _type) && (_type <: typeVar) ->
		(* (Assign4) *)
		typeEnv
	| Type _, _, _ ->
		error 408 (!^reference ^ " not satisfy rule (Assign2) & (Assign4)")
;;

(**
 * TODOC
 * Return part of type environment where the reference is the prefix of
 * the variables. The prefix of variables will be removed when 'cut' is true,
 * otherwise the variables will have original references.
 *)
let rec env_of_ref typeEnv reference cut =
	if reference = [] then typeEnv
	else if typeEnv = [] then []
	else
		List.fold_left
		(
			fun e (r, t) ->
				if reference @< r then
					let re = if cut then (r @-- reference) else r in
					(re, t) :: e
				else e
		) [] typeEnv
;;

(**
 * TODOC
 * @param typeEnv        type environment
 * @param baseReference  namespace where the reference will be resolved
 * @param reference      reference to be resolved
 *)
let rec resolve typeEnv baseReference reference =
	match baseReference, reference with
	| _, "ROOT"   :: rs -> ([], find typeEnv !!rs)
	| _, "PARENT" :: rs ->
		if baseReference = []
			then error 409 "PARENT of root namespace is impossible"
		else
			(prefix baseReference,
				find typeEnv !!((prefix baseReference) @++ rs))
	| _, "THIS"   :: rs ->
		(baseReference, find typeEnv !!(baseReference @++ rs))
	| [], _ -> ([], find typeEnv reference)
	| _, _ ->
		match find typeEnv (baseReference @<< reference) with
		| Undefined -> resolve typeEnv (prefix baseReference) reference
		| _type     -> (baseReference, _type)
;;
	
(**
 * TODOC
 * @param typeEnv      type environment
 * @param prototype    prototype reference whose attributes to be copied
 * @param destination  reference of destination
 *)
let copy typeEnv prototype destination =
	let protoTypeEnv = env_of_ref typeEnv prototype true in
	List.fold_left (
		fun ep (rep, tep) -> (destination @++ rep, tep) :: ep
	) typeEnv protoTypeEnv
;;

(**
 * TODOC
 * @param e     type environment
 * @param ns    namespace where references will be resolved
 * @param proto reference of prototype
 * @param r     target variable
 *)
let inherit_env typeEnv baseReference prototype reference =
	let get_proto =
		match resolve typeEnv baseReference prototype with
		| _, Undefined ->
			error 410 ("prototype is not found: " ^ !^prototype)
		| baseRef, Type TBasic TObject
		| baseRef, Type TBasic TSchema (_, _) ->
			baseRef @++ prototype
		| _, Type _type ->
			error 411 ("invalid prototype " ^ !^reference ^ ":" ^
				(string_of_type _type))
	in
	copy typeEnv get_proto reference
;;

(*******************************************************************
 * second-pass type environment
 *******************************************************************)

(* TODOC resolve forward type assignment for link & data reference *)
let rec resolve_forward_type typeEnv baseReference reference accumulator =
	let follow_forward_type baseRef refType =
		let r = baseRef @++ reference in
		if r @<= refType
			then error 412 ("implicit cyclic reference " ^ !^refType)
		else
			resolve_forward_type typeEnv r refType (SetRef.add r accumulator)
	in
	if SetRef.exists (fun r -> r = reference) accumulator
		then error 413 ("cyclic reference " ^ !^reference)
	else
		match resolve typeEnv baseReference reference with
		| _, Undefined ->
			error 414 ("undefined reference " ^ !^reference ^ " in " ^
				!^baseReference)
		| baseRef, Type TForward (refType, _) ->
			follow_forward_type baseRef refType
		| baseRef, Type _type ->
			(baseRef @++ reference, _type)
;;

(**
 * TODOC
 * visit every element of 'typeEnv', and then replace all TForward elements
 *)
let replace_forward_type_in typeEnv =
	let main = ["main"] in
	let replace e r t tr islink =
		let (proto, t_val) =
			match resolve_forward_type e r tr SetRef.empty with
			| proto, TBasic t ->
				(proto, (if islink then TBasic t else TRef t))
			| proto, TRef _ when not islink ->
				error 415 (!^r ^ " has a value of reference of reference," ^
					" which is not allowed")
			| proto, TVec _ when not islink ->
				error 416 (!^r ^ " has a value of reference of vector," ^
					" which is not allowed")
			| proto, t -> (proto, t)
		in
		let e1 = (r, t_val) :: e in
		if t_val <: TBasic TObject then copy e1 proto r
		else e1
	in
	let rec iter e3 src =
		match src with
		| [] -> e3
		| (r, t) :: tail ->
			if not (main @<= r) || r = main then iter e3 tail
			else
				let result =
					match t with
					| TForward (tr, islink) -> replace e3 r t tr islink
					| _  -> (r, t) :: e3
				in
				iter result tail
	in
	iter typeEnv typeEnv

(* perform second valuation of environment 'e' *)
let second_pass_eval typeEnv =
	let e = replace_forward_type_in typeEnv in
	if is_well_typed e then e
	else error 417 "not well-typed"

let get_main typeEnv =
	let main = ["main"] in
	let rec iter e buf =
		match e with
		| [] -> buf
		| (r, t) :: tail ->
			if not (main @<= r) then iter tail buf
			else
				let r1 = List.tl r in
				if r1 = [] || domain buf r1 then iter tail buf
				else iter tail ((r1, t) :: buf)
	in
	iter typeEnv []

(*******************************************************************
 * type inference functions
 *******************************************************************)

let sfBoolean b = TBasic TBool  (* (Bool) *)

let sfInt i = TBasic TInt (* (Int) *)

let sfFloat f = TBasic TFloat (* (Float) *)

let sfString s = TBasic TStr    (* (Str)  *)

let sfNull = TBasic TNull       (* (Null) *)

let sfReference r = r

(* (Deref Data) *)
let sfDataReference dr : environment -> reference -> _type =
	(**
	 * @param ns namespace
	 * @param e  type environment
	 *)
	fun e ns ->
		let r = (sfReference dr) in
		match resolve e ns r with
		| _, Type (TForward (rz, islink)) -> TForward (rz, islink)
		| _, Type (TBasic t) -> TRef t
		| _, Type (TRef _)   ->
			(* TRef t *)
			error 418 ("reference of reference is not allowed")
		| _, Type (TVec _)   ->
			error 419 ("dereference of " ^ !^r ^ " is a vector")
		| _, Type TUndefined ->
			error 420 ("dereference of " ^ !^r ^ " is Undefined")
		| _, Type TAny       ->
			error 421 ("dereference of " ^ !^r ^ " is Any")
		| _, Undefined       -> TForward (r, false)

(* (Deref Link) *)
let sfLinkReference lr : environment -> reference -> reference ->
	(reference * _type) =
	(**
	 * @param ns namespace
	 * @param e  type environment
	 *)
	fun e ns r ->
		let link = sfReference lr in
		match resolve e ns link with
		| nsp, Undefined -> (nsp @++ link, TForward (link, true))
		| nsp, Type t    -> (nsp @++ link, t)

let rec sfVector vec : environment -> reference -> _type =
	(**
	 * @param ns namespace
	 * @param e  type environment
	 *)
	fun e ns ->
		let rec eval v =  (* (Vec) *)
			match v with
			| [] -> TUndefined
			| head :: tail ->
				let t_head =
					match sfBasicValue head e ns with
					| TRef _ | TForward _ -> TRef TNull
					| t                   -> t
				in
				if tail = [] then t_head
				else if t_head = eval tail then t_head
				else error 422 "types of vector elements are different"
		in
		TVec (eval vec)

and sfBasicValue bv : environment -> reference -> _type =
	(**
	 * @param ns namespace
	 * @param e  type environment
	 *)
	fun e ns ->
		match bv with
		| Boolean b    -> sfBoolean b
		| Int i        -> sfInt i
		| Float f      -> sfFloat f
		| String s     -> sfString s
		| Null         -> sfNull
		| Vector vec   -> sfVector vec e ns
		| Reference dr -> sfDataReference dr e ns

(**
 * @param proto prototype AST element
 * @param first true if this is the first prototype, otherwise false
 * @param t_val the type of the first prototype
 *)
let rec sfPrototype proto first t_val : reference -> reference ->
	environment -> environment =
	(**
	 * @param ns namespace
	 * @param r  target variable
	 * @param e  type environment
	 *)
	fun ns r e ->
		match proto with
		| EmptyPrototype -> (* (Proto1) *)
			if first then assign e r t_val (TBasic TObject)
			else e
		| BlockPrototype (pb, p) -> (* (Proto2) *)
			let t_block =
				if first && t_val = TUndefined then TBasic TObject
				else t_val
			in
			let e1 = assign e r t_val t_block in
			sfPrototype p false t_block ns r (sfpBlock pb r e1)
		| ReferencePrototype (pr, p) ->
			let proto = sfReference pr in
			match resolve e ns proto with
			| _, Undefined -> error 423 ("prototype is not found: " ^ !^proto)
			| _, Type t    -> (* (Proto3) & (Proto4) *)
				let e_proto = assign e r t_val t in
				let t_proto = if first then t else t_val in
				sfPrototype p false t_proto ns r
					(inherit_env e_proto ns proto r)

and sfValue v : reference -> reference -> _type -> environment ->
	environment =
	(**
	 * @param ns namespace
	 * @param r  variable's reference
	 * @param t  predefined type
	 * @param e  type environment
	 *)
	fun ns r t e ->
		match v with
		| TBD -> assign e r t TAny
		| Unknown -> assign e r t TAny
		| Basic bv -> assign e r t (sfBasicValue bv e ns)
		| Link link ->
			(
				let (r_link, t_link) = sfLinkReference link e ns r in
				let e1 = assign e r t t_link in
				if t_link <: TBasic TObject then copy e1 r_link r
				else e1
			)
		| Action a -> assign e r t (TBasic TAction)
		| Prototype (schema, proto) ->
			match schema with
			| SID sid ->
				(
					match find e [sid] with
					| Undefined  ->
						error 424 ("schema " ^ sid ^ " is not exist")
					| Type TBasic TSchema (sid, super)
						when (TBasic super) <: (TBasic TRootSchema) ->
							let t_sid = TBasic (object_of_schema
								(TSchema (sid, super)))
							in
							let e1 = inherit_env e ns [sid] r in
							sfPrototype proto true t_sid ns r e1
					| _ ->
						error 425 (sid ^ " is not a schema")
				)
			| EmptySchema -> sfPrototype proto true TUndefined ns r e

and sfAssignment (r, t, v) : reference -> environment -> environment =
	(**
	 * @param ns namespace
	 * @param e  type environment
	 *)
	fun ns e -> sfValue v ns (ns @++ r) t e

and sfpBlock block : reference -> environment -> environment =
	(**
	 * @param ns namespace
	 * @param e  type environment
	 *)
	fun ns e ->
		match block with
		| AssignmentBlock (a, b) -> sfpBlock b ns (sfAssignment a ns e)
		| GlobalBlock (g, b) -> sfpBlock b ns (sfpGlobal g e)
		| EmptyBlock -> e

and sfpSchema s : environment -> environment =
	let (sid, parent, b) = s in
	fun e ->
		let r_sid = [sid] in
		if domain e r_sid then error 426 ("cannot redefined schema " ^ sid);
		let define_schema r_superid supertype =
			let t_sid = (TBasic (TSchema (sid, supertype))) in
			let e1 = assign e r_sid TUndefined t_sid in
			let e2 =
				if r_superid != [] then inherit_env e1 [] r_superid r_sid
				else e1
			in
			sfpBlock b r_sid e2
		in
		match parent with
		| EmptySchema -> define_schema [] TRootSchema
		| SID superid ->
			match find e [superid] with
			| Undefined        -> error 427 ("super schema " ^ superid ^
			                          " is not exist")
			| Type (TBasic t)  ->
				if is_schema (TBasic t) then define_schema [superid] t
				else error 108 (superid ^ " is not a schema")
			| _                -> error 428 (superid ^ " is not a schema")

and sfpGlobal g : environment -> environment =
	fun e -> assign e ["global"] TUndefined (TBasic TGlobal)

and sfpContext ctx : environment -> environment =
	fun e ->
		match ctx with
		| AssignmentContext (a, c) -> sfpContext c (sfAssignment a [] e)
		| SchemaContext (s, c)     -> sfpContext c (sfpSchema s e)
		| GlobalContext (g, c)     -> sfpContext c (sfpGlobal g e)
		| EmptyContext             -> e

and sfpSpecification sfp =
	let e1 = sfpContext sfp [] in
	if not (domain e1 ["main"]) then error 429 "main object is not exist"
	else
		let e2 = get_main (second_pass_eval e1) in
		let e_main = assign e2 ["global"] TUndefined (TBasic TGlobal) in
		map_of e_main


(*******************************************************************
 * a map from type to set of values
 *******************************************************************)

module MapType = Map.Make ( struct
	type t = _type
	let compare = Pervasives.compare
end )

type type_values = Domain.SetValue.t MapType.t

let values_of _type typeValues =
	if MapType.mem _type typeValues then MapType.find _type typeValues
	else Domain.SetValue.empty

let add_value _type value typeValues =
	MapType.add _type
		(Domain.SetValue.add value (values_of _type typeValues)) typeValues

let make_type_values typeEnvInit flatStoreInit typeEnvGoal flatStoreGoal =
	(** group action effects' values based on their type **)
	let add_action_values environment map =
		let actions = values_of (TBasic TAction) map in
		let add_effect_values =
			List.fold_left (
				fun acc (r, v) ->
					match v with
					| Domain.Boolean _ ->
						add_value (TBasic TBool) (Domain.Basic v) acc
					| Domain.Int     _ ->
						add_value (TBasic TInt) (Domain.Basic v) acc
					| Domain.Float   _ ->
						add_value (TBasic TFloat) (Domain.Basic v) acc
					| Domain.String  _ ->
						add_value (TBasic TStr) (Domain.Basic v) acc
					| Domain.Vector  _ -> (* TODO *)
						error 430 "TODO: adding vector value of effects"
					| _         -> acc
			)
		in
		Domain.SetValue.fold (
			fun v map ->
				match v with
				| Domain.Action (n, ps, c, pre, eff) ->
					add_effect_values map eff
				| _                           -> map
		) actions map
	in
	let null = Domain.Basic Domain.Null in
	let rec add_object (t: basicType) value (t_next: basicType) map =
		let map1 = add_value (TBasic t) value map in
		let map2 = add_value (TRef t) value map1 in
		let map3 = add_value (TRef t) null map2 in
		match t_next with
		| TObject -> add_value (TBasic TObject) value map3
		| TSchema (sid, super) -> add_object t_next value super map3
		| _ ->
			error 431 "super-type is not a schema or an object type"
	in
	let add_store_values typeEnv =
		MapRef.fold (
			fun r v (map: type_values) ->
				match type_of r typeEnv with
				| TUndefined ->
					error 432 ("Type of " ^ !^r ^ " is undefined.")
				| TBasic TSchema (sid, super) ->
					add_object (TSchema (sid, super))
						(Domain.Basic (Domain.Ref r)) super map
				| t -> add_value t v map
		)
	in
	let map00 = add_store_values typeEnvInit flatStoreInit MapType.empty in
	let map01 = add_action_values typeEnvInit map00 in
	let map10 = add_store_values typeEnvGoal flatStoreGoal map01 in
	add_action_values typeEnvGoal map10
