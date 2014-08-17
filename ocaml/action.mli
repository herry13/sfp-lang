open Common
open Domain

(** name * parameters * cost * preconditions * effects **)
type t = reference * basic MapStr.t * cost * basic MapRef.t * basic MapRef.t

type ts = { total: int; actions: t list }

val json_of_actions : t list -> string

val ground_actions : Type.env -> Variable.ts -> Type.typevalue -> _constraint -> _constraint list -> ts

val iter : (t -> unit) -> ts -> unit

val fold : ('a -> t -> 'a) -> 'a -> ts -> 'a

val add : t -> ts -> ts

val empty : ts


val encode_name : int -> reference -> basic MapStr.t -> string

val decode_name : string -> (int * reference * basic MapStr.t)


