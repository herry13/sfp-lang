(* Author: Herry (herry13@gmail.com) *)

type t = {
	variables : Variable.ts;
	actions   : Action.ts;
	global    : Domain._constraint
}

val of_sfp : Syntax.sfp -> Syntax.sfp -> t

val of_files : string -> string -> t

val string_of : t -> string

val variables_of : t -> Variable.ts

val actions_of : t -> Action.ts

val to_sfp_plan : string -> t -> Plan.sequential

val to_raw_sfp_plan : string -> t -> Plan.sequential
