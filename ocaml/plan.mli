type sequential = Action.t list

type parallel = { actions: Action.t array; precedences: (int list) array }

val json_of_sequential : sequential -> string

val parallel_of : sequential -> parallel

val json_of_parallel : parallel -> string