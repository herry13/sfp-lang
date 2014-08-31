open Syntax

val sfpSpecificationFirstPass : sfp -> Domain.store

val sfpSpecificationSecondPass : sfp -> Domain.store

val sfpSpecificationThirdPass : sfp -> Domain.store

(** default valuation function (3 passes) **)
val sfpSpecification : sfp -> Domain.store