type t = { variables: Variable.ts; actions: Action.ts; global: Domain._constraint }

val of_sfp : Syntax.sfp -> Syntax.sfp -> t

val string_of : t -> string

val variables_of : t -> Variable.ts

val actions_of : t -> Action.ts

val to_sfp_plan : string -> t -> Plan.sequential
