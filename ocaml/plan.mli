type sequential = Action.t list

type parallel = { actions: Action.t array; precedences: (int list) array }

val string_of_sequential : sequential -> string

val parallel_of : sequential -> parallel
