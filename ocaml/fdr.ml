open Common
open Domain

type t = { variables: Variable.ts; actions: Action.ts; global: _constraint }


(*******************************************************************
 * functions for translating SFP to FDR
 *******************************************************************)

let version = "3";;

let metric = "1";;

let of_header (buf: Buffer.t) : unit =
	Buffer.add_string buf "begin_version\n";
	Buffer.add_string buf version;
	Buffer.add_string buf "\nend_version\nbegin_metric\n";
	Buffer.add_string buf metric;
	Buffer.add_string buf "\nend_metric";;

let of_variables (buf: Buffer.t) (vars: Variable.ts) : unit =
	Buffer.add_char buf '\n';
	Buffer.add_string buf (string_of_int (Variable.total vars));
	Variable.iter (fun var ->
		Buffer.add_string buf "\nbegin_variable\n";
		Buffer.add_string buf (string_of_int (Variable.index var));
		Buffer.add_char buf '_';
		Buffer.add_string buf !^(Variable.name var);
		Buffer.add_string buf "\n-1\n";
		Buffer.add_string buf (string_of_int (Variable.size var));
		Buffer.add_char buf '\n';
		Variable.iteri_values (fun i v ->
			Buffer.add_string buf "Atom (";
			Buffer.add_string buf !^(Variable.name var);
			Buffer.add_char buf ' ';
			Buffer.add_string buf (json_of_value v);
			Buffer.add_string buf ")\n";
		) var;
		Buffer.add_string buf "end_variable"
	) vars;;

let of_init (buf: Buffer.t) (vars: Variable.ts) : unit =
	Buffer.add_string buf "\nbegin_state";
	Variable.iter (fun var ->
		let i = Variable.index_of_value (Variable.init var) var in
		if i < 0 then error 601; (* initial state is not satisfying the global constraint *)
		Buffer.add_char buf '\n';
		Buffer.add_string buf (string_of_int i)
	) vars;
	Buffer.add_string buf "\nend_state";;

let of_goal (buf: Buffer.t) (vars: Variable.ts) use_dummy : unit =
	let tmp = Buffer.create 50 in
	let counter = ref 0 in
	Variable.iter (fun var ->
		(**
		 * set the variable's goal, when:
		 * - it has more than one value
		 * - if it is a dummy variable, then the global constraint must be exist
		 *)
		let i = Variable.index_of_value (Variable.goal var) var in
		if i < 0 then error 602; (* goal state is not satisfying the global constraint *)
		if (Variable.size var) > 1 && ((Variable.index var) > 0 || use_dummy) then
		(
			Buffer.add_char tmp '\n';
			Buffer.add_string tmp (string_of_int (Variable.index var));
			Buffer.add_char tmp ' ';
			Buffer.add_string tmp (string_of_int i);
			counter := !counter + 1;
		)
	) vars;
	Buffer.add_string buf "\nbegin_goal";
	Buffer.add_char buf '\n';
	Buffer.add_string buf (string_of_int !counter);
	Buffer.add_string buf (Buffer.contents tmp);
	Buffer.add_string buf "\nend_goal";;

(**
 * Generate the FDR mutex
 *)
let of_mutex (buf: Buffer.t) (vars: Variable.ts) : unit =
	Buffer.add_char buf '\n';
	Buffer.add_string buf (string_of_int (Variable.total vars));
	Variable.iter (fun var ->
		Buffer.add_string buf "\nbegin_mutex_group\n";
		let index = string_of_int (Variable.index var) in
		Buffer.add_string buf (string_of_int (Variable.size var));
		Buffer.add_char buf '\n';
		Variable.iteri_values (fun i _ ->
			Buffer.add_string buf index;
			Buffer.add_char buf ' ';
			Buffer.add_string buf (string_of_int i);
			Buffer.add_char buf '\n';
		) var;
		Buffer.add_string buf "end_mutex_group";
	) vars;;

(**
 * Generate the FDR of a given action. If there is an assignment whose value is not
 * in the variable's domain, then the action is treated as "invalid".
 *)
let of_action (buffer: Buffer.t) ((name, params, cost, pre, eff): Action.t) (vars: Variable.ts) counter : unit =
	let valid_operator = ref true in
	let buf = Buffer.create 50 in
	Buffer.add_string buf "\nbegin_operator\n";
	(* name *)
	Buffer.add_string buf (Action.encode_name !counter name params);
	Buffer.add_char buf '\n';
	(* prevail *)
	let prevail = Buffer.create 50 in
	let n = ref 0 in
	MapRef.iter (fun r v ->
		if not (MapRef.mem r eff) then
		(
			let var = Variable.find r vars in
			Buffer.add_string prevail (string_of_int (Variable.index var));
			Buffer.add_char prevail ' ';
			let i = Variable.index_of_value (Basic v) var in
			if i < 0 then valid_operator := false;
			Buffer.add_string prevail (string_of_int i);
			Buffer.add_char prevail '\n';
			n := !n + 1;
		)
	) pre;
	Buffer.add_string buf (string_of_int !n);
	Buffer.add_char buf '\n';
	Buffer.add_string buf (Buffer.contents prevail);
	(* prepost *)
	let temp = Buffer.create 10 in
	let n = ref 0 in
	MapRef.iter (fun r v ->
		let var = Variable.find r vars in
		Buffer.add_string temp "0 ";
		Buffer.add_string temp (string_of_int (Variable.index var));
		Buffer.add_char temp ' ';
		if MapRef.mem r pre then
			let pre_v = MapRef.find r pre in
			let i = Variable.index_of_value (Basic pre_v) var in
			if i < 0 then valid_operator := false;
			Buffer.add_string temp (string_of_int i);
		else
			Buffer.add_string temp "-1";
		Buffer.add_char temp ' ';
		let j = Variable.index_of_value (Basic v) var in
		if j < 0 then valid_operator := false;
		Buffer.add_string temp (string_of_int j);
		Buffer.add_char temp '\n';
		n := !n + 1;
	) eff;
	Buffer.add_string buf (string_of_int !n);
	Buffer.add_char buf '\n';
	Buffer.add_string buf (Buffer.contents temp);
	(* check operator validity *)
	if !valid_operator then (
		(* cost *)
		Buffer.add_string buf (string_of_int cost);
		Buffer.add_string buf "\nend_operator";
		Buffer.add_string buffer (Buffer.contents buf);
		counter := !counter + 1
	)
	else prerr_endline ("Warning: operator " ^ !^name ^ " is invalid")

(* generate FDR of a set of actions *)
let of_actions (buf: Buffer.t) (actions: Action.ts) (vars: Variable.ts) : unit =
	let counter = ref 0 in
	let buf_actions = Buffer.create 50 in
	Action.iter (fun a -> of_action buf_actions a vars counter) actions;
	Buffer.add_char buf '\n';
	Buffer.add_string buf (string_of_int !counter);
	Buffer.add_string buf (Buffer.contents buf_actions);;

(* generate FDR axioms *)
let of_axioms (buf: Buffer.t) : unit =
	Buffer.add_string buf "\n0";;

let of_sfp (ast_0: Syntax.sfp) (ast_g: Syntax.sfp) : t = (* (string * Variable.ts * Action.ts) = *)
	(* step 0: parse the specification and generate a store *)
	let env_0 = Type.sfpSpecification ast_0 in
	let store_0 = Valuation.sfpSpecification ast_0 in
	let env_g = Type.sfpSpecification ast_g in
	let store_g = Valuation.sfpSpecification ast_g in
	(* step 1: generate flat-stores of current and desired specifications *)
	let fs_0 = normalise store_0 in
	let fs_g = normalise store_g in
	(* step 1a: generate a type->value map *)
	let tvalues = Type.make_typevalue env_0 fs_0 env_g fs_g in
	(* step 2: translate *)
	(* step 2.1: generate variables *)
	let vars = Variable.make_ts env_0 fs_0 env_g fs_g tvalues in
	(* step 2.2: global constraints *)
	let (global, g_implies, vars1) = Constraint.global_of env_g fs_g vars in
	(* step 2.3 & 2.4: generate actions & compile global constraints *)
	let actions = Action.ground_actions env_g vars1 tvalues global g_implies in
	{ variables = vars1; actions = actions; global = global }

let string_of (dat: t) : string =
	(* step 2.5: generate FDR *)
	let buffer = Buffer.create (100 + (40 * (Variable.total dat.variables) * 2)) in
	of_header buffer;
	of_variables buffer dat.variables;
	of_mutex buffer dat.variables;
	of_init buffer dat.variables;
	of_goal buffer dat.variables (dat.global <> True);
	of_actions buffer dat.actions dat.variables;
	of_axioms buffer;
	Buffer.contents buffer

let actions_of (dat: t) : Action.ts = dat.actions

let variables_of (dat: t) : Variable.ts = dat.variables

(** convert an FDR plan (in string) to an SFP plan **)
type temp_plan = { plan: Action.t list; prev: Action.t }

(**
 * @param s         string of FDR plan
 * @param dat       FDR data that contains SFP variables and actions
 * @param no_dummy  true to remove dummy operators (by merging their preconditions
 *                  to the following action), false to keep dummy operators
 *
 * @return a sequential plan (list of actions)
 *)
let convert_fdr_to_sfp_plan (s: string) (dat: t) (no_dummy: bool) : Plan.sequential =
	let merge pre1 pre2 =
		let pre = MapRef.fold (fun r v pre ->
				if (List.hd r).[0] = '!' then pre
				else MapRef.add r v pre
			) pre1 pre2
		in
		MapRef.remove Variable.r_dummy pre
	in
	let space = Str.regexp " " in
	let actions = Action.to_array dat.actions in
	let dummy = ([], MapStr.empty, 0, MapRef.empty, MapRef.empty) in
	let temp = List.fold_left (fun acc line ->
			let line = String.sub line 1 ((String.length line)-1) in
			let parts = Str.bounded_split space line 3 in
			let index = int_of_string (List.hd parts) in
			if no_dummy then (
				if (List.hd (List.tl parts)).[3] = '!' then ( (* a dummy operator: "$.!global" *)
					if acc.prev = dummy then (
						{ plan = acc.plan; prev = actions.(index) }
					) else ( (* merge previous dummy operator with the current dummy *)
						let (_, _, _, pre1, _) = acc.prev in
						let (name, params, cost, pre2, eff) = actions.(index) in
						let merge_action = (name, params, cost, (merge pre1 pre2), eff) in
						{ plan = acc.plan; prev = merge_action }
					)
				) else ( (* not a dummy operator *)
					if acc.prev = dummy then (
						{ plan = actions.(index) :: acc.plan; prev = dummy }
					) else ( (* merge previous dummy operator with the current one *)
						let (_, _, _, pre_dummy, _) = acc.prev in
						let (name, params, cost, pre, eff) = actions.(index) in
						let eff = MapRef.remove Variable.r_dummy eff in
						let merge_action = (name, params, cost, (merge pre_dummy pre), eff) in
						{ plan = merge_action :: acc.plan; prev = dummy }
					)
				)
			) else (
				{ plan = actions.(index) :: acc.plan; prev = acc.prev }
			)
		) {plan = []; prev = dummy } (Str.split (Str.regexp "\n") s)
	in
	List.rev temp.plan

let to_sfp_plan (s: string) (dat: t) : Plan.sequential = convert_fdr_to_sfp_plan s dat true

let to_raw_sfp_plan (s: string) (dat: t): Plan.sequential = convert_fdr_to_sfp_plan s dat false