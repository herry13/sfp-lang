open Common
open Domain

(** name * parameters * cost * preconditions * effects **)
(*type t = reference * basic MapStr.t * cost * basic MapRef.t * basic MapRef.t*)
type t = {
	name: reference;
	parameters: basic MapStr.t;
	cost: cost;
	preconditions: basic MapRef.t;
	effects: basic MapRef.t
}

type ts = { total: int; actions: t list }


val make : reference -> basic MapStr.t -> int -> basic MapRef.t -> basic MapRef.t -> t

val name : t -> reference

val parameters : t -> basic MapStr.t

val cost : t -> int

val preconditions : t -> basic MapRef.t

val effects : t -> basic MapRef.t

val json_of : t -> string

val json_of_parallel_action : t -> int list -> int list -> string


val json_of_actions : t list -> string

val ground_actions : Type.env -> Variable.ts -> Type.typevalue -> _constraint -> _constraint list -> ts

val iter : (t -> unit) -> ts -> unit

val fold : ('a -> t -> 'a) -> 'a -> ts -> 'a

val add : t -> ts -> ts

val empty : ts

val to_array : ts -> t array


val encode_name : int -> t -> string

val decode_name : string -> (int * reference * basic MapStr.t)


