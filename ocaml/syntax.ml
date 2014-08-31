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
              | TTBD
              | TUnknown
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
	| TTBD                 -> "§TBD"
	| TUnknown             -> "§unknown"

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