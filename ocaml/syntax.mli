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
and _type     = TBasic of basicType
              | TVec   of _type
              | TRef   of basicType
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
and _constraint = Eq           of reference * basicValue
                | Ne           of reference * basicValue
				| Greater      of reference * basicValue
				| GreaterEqual of reference * basicValue
				| Less         of reference * basicValue
				| LessEqual    of reference * basicValue
                | Not          of _constraint
                | Imply        of _constraint * _constraint
                | And          of _constraint list
                | Or           of _constraint list
                | In           of reference * vector

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

val string_of_sfp : sfp -> string

val string_of_type : _type -> string
