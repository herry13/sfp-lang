open Common
open Domain

(* type Action.t = reference * basic MapStr.t * cost * basic MapRef.t * basic MapRef.t *)
type sequential = Action.t list

type parallel = { actions: Action.t array; precedences: (int list) array }

let string_of_sequential plan =
	let buf = Buffer.create 42 in
	List.iter (fun a ->
		Buffer.add_string buf (Action.json_of a);
		Buffer.add_string buf "\n";
	) plan;
	Buffer.contents buf

(** convert a sequential to a parallel (partial-order) plan **)
let parallel_of (seq: sequential) : parallel =
	let actions = Array.of_list seq in
	let precedences = [| |] in (* TODO -- generate the precedence constraints *)
	{ actions = actions; precedences = precedences }
