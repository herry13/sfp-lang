open Syntax

val sfpSpecificationFirstPass : sfp -> Domain.store

val sfpSpecificationSecondPass : sfp -> Domain.store

val sfpSpecificationThirdPass : sfp -> Domain.store

(** an alias of function sfpSpecificationThirdPass **)
val sfpSpecification : sfp -> Domain.store