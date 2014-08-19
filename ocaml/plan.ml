open Common
open Domain

(* type Action.t = reference * basic MapStr.t * cost * basic MapRef.t * basic MapRef.t *)
type sequential = Action.t array

type parallel = { actions: Action.t array; precedences: SetInt.t array }

(* TODO *)
let sequential_of (plan: parallel) : sequential = [| |]

(** generate a JSON of a sequential plan **)
let json_of_sequential (plan: sequential) : string =
	let buf = Buffer.create 42 in
	Buffer.add_string buf "{\"type\":\"sequential\",\"version\":1,\"actions\":[";
	if plan <> [| |] then (
		Array.iteri (fun i a ->
			if i = 0 then Buffer.add_char buf ',';
			Buffer.add_string buf (Action.json_of a);
		) plan
	);
	Buffer.add_string buf "]}";
	Buffer.contents buf

(** convert a sequential to a parallel (partial-order) plan **)
let parallel_of (seq: sequential) : parallel =
	let actions = seq in
	let precedences = Array.make (Array.length actions) SetInt.empty in
	let prev_indexes = ref [] in
	Array.iteri (fun i (_, _, _, pre, eff) ->
		(* add precedence for supporting actions *)
		MapRef.iter (fun r v ->
			try
				let k = List.find (fun j ->
					let (_, _, _, _, eff) = actions.(j) in
					(MapRef.mem r eff) && ((MapRef.find r eff) = v)
				) !prev_indexes in
				precedences.(i) <- SetInt.add k precedences.(i)
			with Not_found -> ();
		) pre;
		(* add precedence of threatened actions *)
		MapRef.iter (fun r v ->
			List.iter (fun j ->
				let (_, _, _, pre, _) = actions.(j) in
				if (MapRef.mem r pre) && ((MapRef.find r pre) <> v) then
					precedences.(i) <- SetInt.add j precedences.(i)
			) !prev_indexes
		) eff;
		prev_indexes := i :: !prev_indexes;
	) actions;
	{ actions = actions; precedences = precedences }

(** generate a JSON of a parallel plan **)
let json_of_parallel (plan: parallel) : string =
	let buf = Buffer.create 42 in
	Buffer.add_string buf "{\"type\":\"parallel\",\"version\":2,\"actions\":[";
	if (Array.length plan.actions) > 0 then (
		Array.iteri (fun i a ->
			if i > 0 then Buffer.add_char buf ',';
			Buffer.add_string buf (Action.json_of a)
		) plan.actions
	);
	Buffer.add_string buf "],\"precedences\":[";
	Array.iteri (fun i prec ->
		if i > 0 then Buffer.add_char buf ',';
		Buffer.add_char buf '[';
		let els = SetInt.elements prec in
		if els <> [] then (
			Buffer.add_string buf (string_of_int (List.hd els));
			List.iter (fun j ->
				Buffer.add_char buf ',';
				Buffer.add_string buf (string_of_int j);
			) (List.tl els)
		);
		Buffer.add_char buf ']'
	) plan.precedences;
	Buffer.add_string buf "]}";
	Buffer.contents buf
