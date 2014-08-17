type t = { str: string; variables: Variable.ts; actions: Action.ts }

val of_sfp : Syntax.sfp -> Syntax.sfp -> t

val string_of : t -> string

val variables_of : t -> Variable.ts

val actions_of : t -> Action.ts

val fdr_to_sfp_plan : string -> Plan.seq
