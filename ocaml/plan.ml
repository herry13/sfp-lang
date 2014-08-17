open Common
open Domain

type t = Action.t list
(* type Action.t = reference * basic MapStr.t * cost * basic MapRef.t * basic MapRef.t *)

let from_fast_downward (plan: string) : t =
    List.fold_left (fun acc s ->
		let (id, name, params) = Action.decode_name (String.sub s 1 ((String.length s)-2)) in
		let a = (name, params, 0, MapRef.empty, MapRef.empty) in
		a :: acc
    ) [] (Str.split (Str.regexp "\n") plan)

let to_string (plan: t) : string =
    List.fold_left (fun s (r, ps, _, _, _) ->
		s ^ (Action.encode_name 0 r ps) ^ "\n"
		(* s ^ !^r ^ "\n" *)
	) "" plan
