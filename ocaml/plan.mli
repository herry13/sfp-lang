open Common

type sequential = Action.t array

type parallel = { actions: Action.t array; precedences: SetInt.t array }

val sequential_of : parallel -> sequential

val json_of_sequential : sequential -> string

val parallel_of : sequential -> parallel

val json_of_parallel : parallel -> string