open Common
open Domain

(* type Action.t = reference * basic MapStr.t * cost * basic MapRef.t * basic MapRef.t *)
type sequential = Action.t list

type parallel = { actions: Action.t array; precedences: (int list) array }

let json_of_sequential (plan: sequential) : string =
	let buf = Buffer.create 42 in
	Buffer.add_string buf "{\"type\":\"sequential\",\"version\":1,\"actions\":[";
	if plan <> [] then (
		Buffer.add_string buf (Action.json_of (List.hd plan));
		List.iter (fun a ->
			Buffer.add_char buf ',';
			Buffer.add_string buf (Action.json_of a);
		) (List.tl plan)
	);
	Buffer.add_string buf "]}";
	Buffer.contents buf

(** convert a sequential to a parallel (partial-order) plan **)
let parallel_of (seq: sequential) : parallel =
	let actions = Array.of_list seq in
	let precedences = Array.make (Array.length actions) [] in (* TODO -- generate the precedence constraints *)
	{ actions = actions; precedences = precedences }

let json_of_parallel (plan: parallel) : string = (* TODO -- generate precendence constraints *)
	let buf = Buffer.create 42 in
	Buffer.add_string buf "{\"type\":\"parallel\",\"version\":2,\"actions\":[";
	if (Array.length plan.actions) > 0 then (
		Array.iteri (fun i a ->
			if i > 0 then Buffer.add_char buf ',';
			Buffer.add_string buf (Action.json_of a)
		) plan.actions
	);
	Buffer.add_string buf "]}";
	Buffer.contents buf
