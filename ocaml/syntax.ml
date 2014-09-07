open Yojson.Basic

(*******************************************************************
 * abstract syntax tree
 *******************************************************************)
type sf            = block
and  sfp           = context
and  context       = AssignmentContext of assignment * context
                   | SchemaContext     of schema * context
                   | GlobalContext     of _constraint * context
                   | EmptyContext
and  block         = AssignmentBlock of assignment * block
                   | GlobalBlock     of _constraint * block
                   | EmptyBlock
and  assignment    = reference * _type * value
and  value         = Basic     of basicValue
                   | Link      of reference
                   | Prototype of superSchema * prototype
                   | Action    of action
                   | TBD
                   | Unknown
                   | Nothing
and  prototype     = ReferencePrototype of reference * prototype
                   | BlockPrototype     of block * prototype
                   | EmptyPrototype
and  basicValue    = Boolean   of string
                   | Int       of string
                   | Float     of string
                   | String    of string
                   | Null
                   | Vector    of vector
                   | Reference of reference
and  vector        = basicValue list
and  reference     = string list

(** schema syntax **)
and schema      = string * superSchema * block
and superSchema = SID of string
                | EmptySchema

(** type syntax **)
and _type     = TBasic   of basicType
              | TVec     of _type
              | TRef     of basicType
                (* link-reference = (r, true)
                   data-reference = (r, false) *)
              | TForward of reference * bool
              | TUndefined
              | TAny
and basicType = TBool                         (* (Type Bool)   *)
              | TInt                          (* (Type Int)    *)
              | TFloat                        (* (Type Float)  *)
              | TStr                          (* (Type Str)    *)
              | TObject                       (* (Type Object) *)
              | TSchema of string * basicType (* (Type Schema) *)
              | TNull                         (* (Type Null)   *)
              | TAction                       (* (Type Action) *)
              | TGlobal                       (* (Type Global) *)
              | TRootSchema

(** constraint syntax **)
and _constraint = Eq of reference * basicValue
                | Ne of reference * basicValue
				| Greater of reference * basicValue
				| GreaterEqual of reference * basicValue
				| Less of reference * basicValue
				| LessEqual of reference * basicValue
                | Not of _constraint
                | Imply of _constraint * _constraint
                | And of _constraint list
                | Or of _constraint list
                | In of reference * vector

(** action syntax **)
and action     = parameter list * cost * conditions * effect list
and parameter  = string * _type
and cost       = Cost of string
               | EmptyCost
and conditions = Condition of _constraint
               | EmptyCondition
and effect     = reference * basicValue

exception SyntaxError of int * string

let error code message =
	match message with
	| "" ->
		raise (SyntaxError (code, "[err" ^ (string_of_int code) ^ "]"))
	| _ ->
		raise (SyntaxError (code, "[err" ^ (string_of_int code) ^ "] - " ^
			message))
;;

(*******************************************************************
 * functions to convert elements of abstract syntax tree to string
 *******************************************************************)
let rec string_of_sf sf = string_of_block sf

and string_of_block = function
	| AssignmentBlock (a, b) -> (string_of_assignment a) ^ "\n" ^
	                                (string_of_block b)
	| GlobalBlock (g, b) -> (string_of_global g) ^ "\n" ^ (string_of_block b)
	| EmptyBlock -> ""

and string_of_assignment = function
	| (r, t, v) -> (string_of_ref r) ^ ":" ^ (string_of_type t) ^
	                   (string_of_value v)

and string_of_value = function
	| Basic bv      -> " " ^ (string_of_basic_value bv) ^ ";"
	| Link lr      -> " " ^ (string_of_ref lr) ^ ";"
	| Prototype (sid, p) -> (string_of_super_schema sid) ^ (string_of_proto p)
	| Action a       -> string_of_action a
	| TBD        -> " TBD"
	| Unknown -> " Unknown"
	| Nothing -> " Nothing"

and string_of_proto = function
	| ReferencePrototype (r, p) -> " extends " ^ (string_of_ref r) ^
	                                   (string_of_proto p)
	| BlockPrototype (b, p)     -> " extends {\n" ^ (string_of_block b) ^
	                                   "}\n" ^ (string_of_proto p)
	| EmptyPrototype            -> ""

and string_of_basic_value = function
	| Boolean x
	| Int x
	| Float x
	| String x     -> x
	| Null         -> "NULL"
	| Vector vec   -> "[" ^ (string_of_vector vec) ^ "]"
	| Reference dr -> "DATA " ^ (string_of_ref dr)

and string_of_vector = function
	| []           -> ""
	| head :: []   -> string_of_basic_value head
	| head :: tail -> (string_of_basic_value head) ^ "," ^
	                      (string_of_vector tail)

and string_of_ref = String.concat "."

and (!^) r = string_of_ref r

and string_of_type = function
	| TBasic bt            -> string_of_basic_type bt
	| TVec t               -> "[]" ^ (string_of_type t)
	| TRef bt              -> "*" ^ (string_of_basic_type bt)
	| TForward (r, islink) -> "?(" ^ (if islink then "" else "*") ^
	                              (String.concat "." r) ^ ")"
	| TUndefined           -> "!"
	| TAny                 -> "any"

and string_of_basic_type = function
	| TBool               -> "bool"
	| TInt                -> "int"
	| TFloat              -> "float"
	| TStr                -> "str"
	| TObject             -> "obj"
	| TSchema (id, super) -> "@" ^ id ^ "<:" ^ (string_of_basic_type super)
	| TRootSchema         -> "@@"
	| TNull               -> "null"
	| TAction             -> "act"
	| TGlobal             -> "glob"

and string_of_super_schema = function
	| SID id      -> " isa " ^ id
	| EmptySchema -> ""

and string_of_schema (sid, ss, b) =
	sid ^ (string_of_super_schema ss) ^ " {\n" ^ (string_of_block b) ^ "}"

and string_of_context = function
	| AssignmentContext (a, c) -> (string_of_assignment a) ^ "\n" ^
	                                  (string_of_context c)
	| SchemaContext (s, c)     -> (string_of_schema s) ^ "\n" ^
	                                  (string_of_context c)
	| GlobalContext (g, c)     -> (string_of_global g) ^ "\n" ^
	                                  (string_of_context c)
	| EmptyContext             -> ""

and string_of_sfp sfp = string_of_context sfp

(** constraints *)
and string_of_global g =
	"global " ^ (string_of_constraint g) ^ "\n"

and string_of_constraint = function
	| Eq (r, bv)      -> "(= " ^ !^r ^ " " ^ (string_of_basic_value bv) ^ ")"
	| Ne (r, bv)      -> "(!= " ^ !^r ^ " " ^ (string_of_basic_value bv) ^ ")"
	| Not c           -> "(not " ^ (string_of_constraint c) ^ ")"
	| Imply (c1, c2)  -> "(imply " ^ (string_of_constraint c1) ^ " " ^
	                         (string_of_constraint c2) ^ ")"
	| And cs          -> (List.fold_left (fun s c -> s ^ " " ^
	                         (string_of_constraint c)) "(and " cs) ^ ")"
	| Or cs           -> (List.fold_left (fun s c -> s ^ " " ^
	                         (string_of_constraint c)) "(or " cs) ^ ")"
	| In (r, vec)     -> "(in " ^ !^r ^ " " ^ (string_of_vector vec) ^ ")"
	| Greater (r, bv) -> "(> " ^ !^r ^ " " ^ (string_of_basic_value bv) ^ ")"
	| GreaterEqual (r, bv) -> "(>= " ^ !^r ^ " " ^
	                              (string_of_basic_value bv) ^ ")"
	| Less (r, bv)    -> "(< " ^ !^r ^ " " ^ (string_of_basic_value bv) ^ ")"
	| LessEqual (r, bv) -> "(<= " ^ !^r ^ " " ^ (string_of_basic_value bv) ^
	                           ")"

(** action **)
and string_of_effect (r, bv) =
	"(= " ^ !^r ^ " " ^ (string_of_basic_value bv) ^ ")"

and string_of_effects effs =
	(List.fold_left (fun s e -> s ^ " " ^ (string_of_effect e)) "(effects "
	    effs) ^ ")"

and string_of_conditions = function
	| EmptyCondition -> ""
	| Condition c         -> "(conditions " ^ (string_of_constraint c) ^ ")"

and string_of_cost = function
	| EmptyCost -> ""
	| Cost c    -> "(cost " ^ c ^ ")"

and string_of_parameter (id, t) = "(= " ^ id ^ " " ^ (string_of_type t) ^ ")"

and string_of_parameters params =
	(
		List.fold_left (
			fun s p -> s ^ " " ^ (string_of_parameter p)
		) "(params " params
	) ^ ")"

and string_of_action (params, cost, conds, effs) =
	"(action " ^ (string_of_parameters params) ^ " " ^
	    (string_of_conditions conds) ^ " " ^ (string_of_effects effs) ^ ")"
;;

let json_of_sfp sfp =
	let buf = Buffer.create 42 in
	let rec json_of_basic_type t = match t with
		| TBool -> Buffer.add_string buf "\"bool\""
		| TInt -> Buffer.add_string buf "\"int\""
		| TFloat -> Buffer.add_string buf "\"float\""
		| TStr -> Buffer.add_string buf "\"string\""
		| TObject -> Buffer.add_string buf "\"object\""
		| TSchema (id, super) -> (
				Buffer.add_char buf '"';
				Buffer.add_string buf id;
				Buffer.add_char buf '"'
			)
		| _ -> error 301 ("invalid type: " ^ (string_of_basic_type t))
	and json_of_type t = match t with
		| TBasic t -> json_of_basic_type t
		| TVec t -> (
				Buffer.add_string buf "[\"vector\",";
				json_of_type t;
				Buffer.add_char buf ']'
			)
		| TRef t -> (
				Buffer.add_string buf "[\"reference\",";
				json_of_basic_type t;
				Buffer.add_char buf ']'
			)
		| TAny -> Buffer.add_string buf "\"any\""
		| _ -> error 302 ("invalid type: " ^ (string_of_type t))
	and json_of_basic_value v =
		match v with
		| Boolean x
		| Int x
		| Float x -> Buffer.add_string buf x
		| String s -> Buffer.add_string buf (to_string (`String s))
		| Null -> Buffer.add_string buf "null"
		| Vector vec -> (
				Buffer.add_char buf '[';
				json_of_vector vec;
				Buffer.add_char buf ']'
			)
		| Reference r -> (
				Buffer.add_string buf "\"$.";
				Buffer.add_string buf (String.concat "." r);
				Buffer.add_char buf '"'
			)
	and json_of_vector vec =
		match vec with
		| [] -> ()
		| head :: [] -> json_of_basic_value head
		| head :: tail -> (
				json_of_basic_value head;
				Buffer.add_char buf ',';
				json_of_vector tail
			)
	and json_of_super_schema super =
		match super with
		| SID id -> (
				Buffer.add_char buf '"';
				Buffer.add_string buf id;
				Buffer.add_char buf '"'
			)
		| EmptySchema -> Buffer.add_string buf "null"
	and json_of_prototype ?first:(fst=true) p =
		match p with
		| ReferencePrototype (r, p) -> (
				if not fst then Buffer.add_char buf ',';
				Buffer.add_char buf '"';
				Buffer.add_string buf !^r;
				Buffer.add_char buf '"';
				json_of_prototype ~first:false p
			)
		| BlockPrototype (b, p) -> (
				if not fst then Buffer.add_char buf ',';
				Buffer.add_char buf '[';
				json_of_block b;
				Buffer.add_char buf ']';
				json_of_prototype ~first:false p
			)
		| EmptyPrototype -> ()
	and json_of_value v =
		match v with
		| Basic bv -> json_of_basic_value bv
		| Link r -> (
				Buffer.add_string buf "\"§.";
				Buffer.add_string buf !^r;
				Buffer.add_char buf '"'
			)
		| Prototype (sid, p) -> (
				Buffer.add_string buf "[\"object\",";
				json_of_super_schema sid;
				Buffer.add_string buf "],[";
				json_of_prototype p;
				Buffer.add_char buf ']'
			)
		| Action a -> json_of_action a
		| TBD -> Buffer.add_string buf "\"§TBD\""
		| Unknown -> Buffer.add_string buf "\"§unknown\""
		| Nothing -> Buffer.add_string buf "\"§nothing\""
	and json_of_action (parameters, cost, conditions, effects) =
		Buffer.add_string buf "\"action\",{\"parameters\":{";
		(* parameters *)
		let rec json_of_parameters ps =
			match ps with
			| [] -> ()
			| (id, t) :: [] -> (
					Buffer.add_string buf "\"";
					Buffer.add_string buf id;
					Buffer.add_string buf "\":";
					json_of_type t;
				)
			| (id, t) :: rest -> (
					Buffer.add_string buf "\"";
					Buffer.add_string buf id;
					Buffer.add_string buf "\":";
					json_of_type t;
					Buffer.add_char buf ',';
					json_of_parameters rest
				)
		in
		json_of_parameters parameters;
		Buffer.add_string buf "},\"cost\":";
		(* cost *)
		(
			match cost with
			| Cost c -> Buffer.add_string buf c;
			| EmptyCost -> Buffer.add_string buf "null"
		);
		(* conditions *)
		Buffer.add_string buf ",\"conditions\":";
		(
			match conditions with
			| Condition c -> json_of_constraint c
			| EmptyCondition -> Buffer.add_string buf "null"
		);
		(* effects *)
		Buffer.add_string buf ",\"effects\":[";
		let rec json_of_effects eff =
			match eff with
			| [] -> ()
			| (r, v) :: [] -> formula_to_json "=" r v
			| (r, v) :: rest -> (
					formula_to_json "=" r v;
					json_of_effects rest
				)
		in
		json_of_effects effects;
		Buffer.add_string buf "]}"
	and formula_to_json operator r v =
		Buffer.add_string buf "[\"";
		Buffer.add_string buf operator;
		Buffer.add_string buf "\",\"";
		Buffer.add_string buf !^r;
		Buffer.add_string buf "\",";
		json_of_basic_value v;
		Buffer.add_char buf ']'
	and	json_of_constraint c =
		match c with
		| Eq (r, v) -> formula_to_json "=" r v
		| Ne (r, v) -> formula_to_json "!=" r v
		| In (r, vec) -> formula_to_json "in" r (Vector vec)
		| Greater (r, v) -> formula_to_json ">" r v
		| GreaterEqual (r, v) -> formula_to_json ">=" r v
		| Less (r, v) -> formula_to_json "<" r v
		| LessEqual (r, v) -> formula_to_json "<=" r v
		| Not c -> (
				Buffer.add_string buf "[\"not\",";
				json_of_constraint c;
				Buffer.add_char buf ']'
			)
		| Imply (c1, c2) -> (
				Buffer.add_string buf "[\"imply\",";
				json_of_constraint c1;
				Buffer.add_char buf ',';
				json_of_constraint c2;
				Buffer.add_char buf ']'
			)
		| And cs -> (
				Buffer.add_string buf "[\"and\"";
				List.iter (fun c ->
					Buffer.add_char buf ',';
					json_of_constraint c
				) cs;
				Buffer.add_char buf ']'
			)
		| Or cs -> (
				Buffer.add_string buf "[\"or\"";
				List.iter (fun c ->
					Buffer.add_char buf ',';
					json_of_constraint c
				) cs;
				Buffer.add_char buf ']'
			)
	and json_of_global g =
		Buffer.add_string buf "[\"global\",";
		json_of_constraint g;
		Buffer.add_char buf ']'
	and json_of_schema (sid, ss, b) =
		Buffer.add_string buf "[\"";
		Buffer.add_string buf sid;
		Buffer.add_string buf "\",[\"schema\",";
		json_of_super_schema ss;
		Buffer.add_string buf "],[";
		json_of_block b;
		Buffer.add_string buf "]]"
	and json_of_assignment (r, t, v) =
		Buffer.add_string buf "[\"";
		Buffer.add_string buf !^r;
		Buffer.add_string buf "\",";
		match t with
		| TUndefined -> (
				json_of_value v;
				Buffer.add_char buf ']'
			)
		| _ -> (
				json_of_type t;
				Buffer.add_char buf ',';
				json_of_value v;
				Buffer.add_char buf ']'
			)
	and json_of_block ?first:(fst=true) block = match block with
		| AssignmentBlock (a, b) -> (
				if not fst then Buffer.add_char buf ',';
				json_of_assignment a;
				json_of_block ~first:false b
			)
		| GlobalBlock (g, b) -> (
				if not fst then Buffer.add_char buf ',';
				json_of_global g;
				json_of_block ~first:false b
			)
		| EmptyBlock -> ()
	and json_of_context ?first:(fst=true) context =
		match context with
		| AssignmentContext (a, c) -> (
				if not fst then Buffer.add_char buf ',';
				json_of_assignment a;
				json_of_context ~first:false c
			)
		| SchemaContext (s, c) -> (
				if not fst then Buffer.add_char buf ',';
				json_of_schema s;
				json_of_context ~first:false c
			)
		| GlobalContext (g, c) -> (
				if not fst then Buffer.add_char buf ',';
				json_of_global g;
				json_of_context ~first:false c
			)
		| EmptyContext -> ()
	in
	Buffer.add_char buf '[';
	json_of_context sfp;
	Buffer.add_char buf ']';
	Buffer.contents buf
;;
	
let sfp_of_json json =
	EmptyContext (* TODO *)