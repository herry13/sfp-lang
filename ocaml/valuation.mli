(* Author: Herry (herry13@gmail.com) *)

open Syntax

val sfpSpecificationFirstPass : sfp -> Domain.store

val sfpSpecificationSecondPass : ?main:string list -> sfp -> Domain.store

val sfpSpecificationThirdPass : ?main:string list -> sfp -> Domain.store

(** default valuation function (3 passes) **)
val sfpSpecification : ?main:string list -> sfp -> Domain.store
