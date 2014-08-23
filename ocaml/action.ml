open Printf
open Common
open Domain

(** type of a single action **)
(*type t = reference * basic MapStr.t * cost * basic MapRef.t * basic MapRef.t;;*)
type t = {
	name: reference;
	parameters: basic MapStr.t;
	cost: cost;
	preconditions: basic MapRef.t;
	effects: basic MapRef.t
}

(** type of a collection of actions **)
type ts = { total: int; actions: t list };;


let make name params cost pre eff =
	{ name = name; parameters = params; cost = cost; preconditions = pre; effects = eff };;
	
let name a = a.name;;
let parameters a = a.parameters;;
let cost a = a.cost;;
let preconditions a = a.preconditions;;
let effects a = a.effects;;


(******************************************************************************
 * Functions to operate over a collection of actions (ts)
 ******************************************************************************)

let iter (f: t -> unit) (acts: ts) : unit = List.iter f acts.actions;;

let fold (f: 'a -> t -> 'a) (acc: 'a) (acts: ts) : 'a = List.fold_left f acc acts.actions;;

let add (a: t) (acts: ts) : ts = { total = acts.total + 1; actions = a :: acts.actions };;

let empty : ts = { total = 0; actions = [] };;

let to_array (acts: ts) : t array = Array.of_list acts.actions;;


(******************************************************************************
 * Functions to generate JSON of actions.
 ******************************************************************************)



let json_of_parameters (buf: Buffer.t) (ps: basic MapStr.t) : unit =
	Buffer.add_char buf '{';
	let first = ref 1 in
	MapStr.iter (fun id v ->
		if !first = 0 then Buffer.add_char buf ',';
		Buffer.add_char buf '"';
		Buffer.add_string buf id;
		Buffer.add_string buf "\":";
		Buffer.add_string buf (json_of_value (Basic v));
		first := 0
	) ps;
	Buffer.add_char buf '}'
;;

let json_of_preconditions (buf: Buffer.t) (pre: basic MapRef.t) : unit =
	Buffer.add_char buf '{';
	let first = ref 1 in
	MapRef.iter (fun r v ->
		if !first = 0 then Buffer.add_char buf ',';
		Buffer.add_char buf '"';
		Buffer.add_string buf !^r;
		Buffer.add_string buf "\":";
		Buffer.add_string buf (json_of_value (Basic v));
		first := 0
	) pre;
	Buffer.add_char buf '}'
;;

let json_of_effects = json_of_preconditions;;

let json_of_elements (buf: Buffer.t) (a: t) =
	Buffer.add_string buf "\"name\":\"";
	Buffer.add_string buf !^(a.name);
	Buffer.add_string buf "\",\"parameters\":";
	json_of_parameters buf a.parameters;
	Buffer.add_string buf ",\"cost\":";
	Buffer.add_string buf (string_of_int a.cost);
	Buffer.add_string buf ",\"conditions\":";
	json_of_preconditions buf a.preconditions;
	Buffer.add_string buf ",\"effects\":";
	json_of_effects buf a.effects
;;

let json_of (a: t) : string =
	let buf = Buffer.create 42 in
	Buffer.add_char buf '{';
	json_of_elements buf a;
	Buffer.add_char buf '}';
	Buffer.contents buf
;;

let json_of_parallel_action (a: t) (before: int list) (after: int list) : string =
	let buf = Buffer.create 42 in
	let to_json elements =
		Buffer.add_char buf '[';
		if elements <> [] then (
			Buffer.add_string buf (string_of_int (List.hd elements));
			List.iter (fun j ->
				Buffer.add_char buf ',';
				Buffer.add_string buf (string_of_int j)
			) (List.tl elements)
		);
		Buffer.add_char buf ']'
	in
	Buffer.add_char buf '{';
	json_of_elements buf a;
	Buffer.add_string buf ",\"before\":";
	to_json before;
	Buffer.add_string buf ",\"after\":";
	to_json after;
	Buffer.add_char buf '}';
	Buffer.contents buf
;;


let json_of_actions (actions: t list) : string =
	match actions with
	| [] -> "[]"
	| act :: [] -> "[" ^ (json_of act) ^ "]"
	| act :: acts -> "[" ^ (json_of act) ^ (List.fold_left (fun s a -> s ^ "," ^ (json_of a)) "" acts) ^ "]"
;;

(******************************************************************************
 * Functions to encode/decode actions' name. This will be used in FDR.
 ******************************************************************************)

let encode_name id a =
	let buf = Buffer.create 42 in
	Buffer.add_string buf (string_of_int id);
	Buffer.add_string buf " \"";
	Buffer.add_string buf !^(a.name);
	Buffer.add_string buf "\" ";
	json_of_parameters buf a.parameters;
	Buffer.contents buf
;;

let decode_name (s: string): int * reference * basic MapStr.t =
	let rec iter_param (map: basic MapStr.t) ps =
		match ps with
		| [] -> map
		| (id, _) :: tail when id = "this" -> iter_param map tail
		| (id, (Basic v)) :: tail -> iter_param (MapStr.add id v map) tail
		| _ -> error 806
	in
	match Str.bounded_split (Str.regexp " ") s 3 with
	| s1 :: s2 :: s3 :: [] -> (
			let id = int_of_string s1 in
			let name =
				match from_json s2 with
				| Basic (Ref r) -> r
				| _ -> error 803
			in
			let params =
				match from_json s3 with
				| Store s -> iter_param MapStr.empty s
				| _       -> error 805
			in
			(id, name, params)
		)
	| _ -> error 804
;;

(******************************************************************************
 * Functions to ground actions.
 ******************************************************************************)

(* convert a list of (identifier => type) to a list of maps of (identifier => value) *)
let create_parameter_table params name (tvalues: Type.typevalue) =
	let table1 = MapStr.add "this" [Ref (prefix name)] MapStr.empty in
	let table2 = List.fold_left (fun table (id, t) ->
			let values = SetValue.fold (fun v acc ->
					match v with
					| Basic bv -> bv :: acc
					| _ -> acc
				) (Type.values_of t tvalues) []
			in
			MapStr.add id values table
		) table1 params
	in
	MapStr.fold (fun id values acc1 ->
		List.fold_left (fun acc2 v ->
			if acc1 = [] then (MapStr.add id v MapStr.empty) :: acc2
			else List.fold_left (fun acc3 table -> (MapStr.add id v table) :: acc3) acc2 acc1
		) [] values
	) table2 []
;;

let equals_to_map = fun map c ->
	match c with
	| Eq (r, v) -> MapRef.add r v map
	| _         -> error 520
;;

(** for each clause of global constraints DNF, create a dummy action **)
let create_global_actions (global: _constraint) (acc: ts) : ts =
	let pre = MapRef.add Variable.r_dummy (Boolean false) MapRef.empty in
	let eff = MapRef.add Variable.r_dummy (Boolean true) MapRef.empty in
	let params = MapStr.empty in
	let counter = ref 0 in
	match global with
	| True  -> acc
	| Or cs -> List.fold_left (fun (acc1: ts) c ->
			let name = ["!global" ^ (string_of_int !counter)] in
			counter := !counter + 1;
			match c with
			| And css   ->
				let pre1 = List.fold_left equals_to_map pre css in
				let a = { name = name; parameters = params; cost = 0; preconditions = pre1; effects = eff } in
				add a acc1
			| Eq (r, v) ->
				let pre1 = MapRef.add r v pre in
				let a = { name = name; parameters = params; cost = 0; preconditions = pre1; effects = eff } in
				add a acc1
			| _         -> error 523
		) acc cs
	| And cs ->
		let name = ["!global"] in
		let pre1 = List.fold_left equals_to_map pre cs in
		let a = { name = name; parameters = params; cost = 0; preconditions = pre1; effects = eff } in
		add a acc
	| _      -> error 524
;;

(**
 * Compile simple implication of global constraints by modifying precondition of actions.
 * @param pre        precondition of an action
 * @param eff        effect of an action
 * @param vars       data structure that holds the variables
 * @param g_implies  a list of simple implication formula
 *
 * @return a list of preconditions, each of which is for an action
 *)
let compile_simple_implication pre eff vars g_implies =
	let modified = ref false in
	let rec iter lpre cs =
		if lpre = [] then lpre else
		match cs with
		| [] -> lpre
		| Imply (Eq (rp, vp), Eq (rc, vc)) :: css ->
			let compile map pre =
				if (MapRef.mem rp map) && (MapRef.find rp map) = vp then   (* mem |= premise *)
					if (MapRef.mem rc pre) then (
						if (MapRef.find rc pre) <> vc then []              (* pre not|= conclusion *)
						else [pre]                                         (* pre |= conclusion *)
					) else (
						modified := true;       (* add extra precondition such that pre |= conclusion *)
						[MapRef.add rc vc pre]
					)
				else if (MapRef.mem rc map) && (MapRef.find rc map) <> vc then   (* mem not|= conclusion *)
					if (MapRef.mem rp pre) && (MapRef.find rp pre) = vp then []  (* pre |= premise *)
					else (
						Array.fold_left (fun acc v ->
							match v with
					     	| Basic vx when vx <> vp -> (
									if MapRef.mem rp pre then (
										if (MapRef.find rp pre) <> vp then pre :: acc  (* pre |= premise = true *)
										else acc                                       (* pre |= premise = false *)
									) else (
										modified := true;    (* add extra precondition such that pre |= conclusion *)
										(MapRef.add rp vx pre) :: acc
									)
								)
							| _ -> acc
						) [] (Variable.values_of rp vars)
					)
				else [pre]
			in
			let lpre1 = List.fold_left (fun lpre1 pre ->
					let lpre2 = compile pre pre in
					List.fold_left (fun lpre3 pre -> List.append (compile eff pre) lpre3) [] lpre2
				) [] lpre
			in
			iter lpre1 css
		| _ -> error 1001
	in
	let rec compile lpre =
		let lpre1 = iter lpre g_implies in
		if !modified then (
			modified := false;
			compile lpre1
		) else lpre1
	in
	compile [pre]
;;

(**
 * Ground an SFP action.
 * 1. substitute the parameters
 * 2. convert the preconditions into the DNF-formula
 * 3. foreach DNF clause, copy the original action and set the clause as the preconditions
 * 4. apply simple implication compilation
 *
 * returns a list of grounded actions
 *)
let ground_action_of (name, params, cost, pre, eff) env vars typevalue dummy g_implies acc : ts =
	let param_tables = create_parameter_table params name typevalue in
	List.fold_left (fun acc1 ps ->
		let eff1 = List.fold_left (fun acc (r, bv) ->
				let r1 = substitute_parameter_of_reference r ps in
				let bv1 = substitute_parameter_of_basic_value bv ps in
				MapRef.add r1 bv1 acc
			) MapRef.empty eff
		in
		let eff2 = if dummy then MapRef.add Variable.r_dummy (Boolean false) eff1 else eff1 in
		let pre1 = Constraint.substitute_parameters_of pre ps in
		let pre2 = if dummy then MapRef.add Variable.r_dummy (Boolean true) MapRef.empty else MapRef.empty in
		match Constraint.dnf_of pre1 vars env with
		| False -> acc1
		| Or cs -> List.fold_left (fun acc2 c ->
				let pre3 =
					match c with
					| Eq (r, v) -> MapRef.add r v pre2
					| And css   -> List.fold_left equals_to_map pre2 css
					| _         -> error 521
				in
				List.fold_left (fun acc3 pre4 ->
					let a = { name = name; parameters = ps; cost = cost; preconditions = pre4; effects = eff2 } in
					add a acc3
				) acc2 (compile_simple_implication pre3 eff2 vars g_implies)
			) acc1 cs
		| And css   ->
			let pre3 = List.fold_left equals_to_map pre2 css in
			List.fold_left (fun acc2 pre4 ->
				let a = { name = name; parameters = ps; cost = cost; preconditions = pre4; effects = eff2 } in
				add a acc2
			) acc1 (compile_simple_implication pre3 eff2 vars g_implies)
		| Eq (r, v) ->
			let pre3 = MapRef.add r v pre2 in
			List.fold_left (fun acc2 pre4 ->
				let a = { name = name; parameters = ps; cost = cost; preconditions = pre4; effects = eff2 } in
				add a acc2
			) acc1 (compile_simple_implication pre3 eff2 vars g_implies)
		| True      ->
			List.fold_left (fun acc2 pre3 ->
				let a = { name = name; parameters = ps; cost = cost; preconditions = pre3; effects = eff2 } in
				add a acc2
			) acc1 (compile_simple_implication pre2 eff2 vars g_implies)
		| _         -> error 522
	) acc param_tables
;;

(* ground a set of actions - returns a list of grounded actions *)
let ground_actions (env: Type.env) (vars: Variable.ts) (tvalues: Type.typevalue) (global: _constraint)
                   (g_implies : _constraint list) : ts =
	let add_dummy = not (global = True) in
	let actions = create_global_actions global empty in
	SetValue.fold (fun v acc ->
		match v with
		| Action a -> ground_action_of a env vars tvalues add_dummy g_implies acc
		| _        -> acc
	) (Type.values_of (Syntax.TBasic Syntax.TAction) tvalues) actions
;;