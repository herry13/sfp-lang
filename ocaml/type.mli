(* Author: Herry (herry13@gmail.com) *)

open Common

(*******************************************************************
 * type environment
 *******************************************************************)

type map = Syntax._type MapRef.t

(*******************************************************************
 * functions of type environment
 *******************************************************************)

exception TypeError of int * string

val string_of_map : map -> string

val sfpSpecification : Syntax.sfp -> map

val type_of : Domain.reference -> map -> Syntax._type

val subtype : Syntax._type -> Syntax._type -> bool


(*******************************************************************
 * a map from type to set of values
 *******************************************************************)

module MapType : Map.S with type key = Syntax._type

type type_values = Domain.SetValue.t MapType.t

val values_of : Syntax._type -> type_values -> Domain.SetValue.t

val add_value : Syntax._type -> Domain.value -> type_values -> type_values

val make_type_values : map -> Domain.flatstore -> map ->
	Domain.flatstore -> Domain.SetValue.t MapType.t
