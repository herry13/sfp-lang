(* Author: Herry (herry13@gmail.com)
   Serialisation/Deserialisation to/from JSON *)

val of_store : Type.map -> Domain.store -> string

val of_constraint : Domain._constraint -> string

val of_value : Domain.value -> string

val of_flatstore : Domain.flatstore -> string

val of_type : Syntax._type -> string


val to_store : string -> Type.map * Domain.store