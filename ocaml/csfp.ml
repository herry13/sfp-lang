(* author: Herry (herry13@gmail.com) *)

open Array

let ast_of_file file =
	let dummyLexbuf = Lexing.from_string "" in
	let lexstack = Parser_helper.create file Lexer.token in
	try
		Parser.sfp (Parser_helper.get_token lexstack) dummyLexbuf
	with e ->
		try
			Parser_helper.check_error e lexstack
		with
		| Parser_helper.ParseError (fname, lnum, lpos, token) ->
			prerr_string ("--- Parse error ---\nfile:   " ^ fname ^
				"\nline:   " ^ (string_of_int lnum) ^
				"\ncolumn: " ^ (string_of_int lpos) ^
				"\ntoken:  '" ^ token ^ "'\n\n");
			exit 1
		| e -> raise e
;;

let fd_plan init goal =
	let fd_preprocessor = "FD_PREPROCESS" in
	let fd_search       = "FD_SEARCH" in
	let fd_option       = "FD_OPTIONS" in
	let fd_debug        = "FD_DEBUG" in
	let sas_file        = "output.sas" in
	let plan_file       = "sas_plan" in
	let default_search_options = "--search \"lazy_greedy(ff())\"" in
	try
		let preprocessor   = Sys.getenv fd_preprocessor in
		let search         = Sys.getenv fd_search in
		let search_options =
			try
				Sys.getenv fd_option
			with
				e -> default_search_options
		in
		let debug =
			try
				let _ = Sys.getenv fd_debug in
				true
			with
				e -> false
		in
		if not (Sys.file_exists preprocessor) then (
			prerr_string ("Error: " ^ preprocessor ^ " is not exist!\n\n");
			exit 1
		);
		if not (Sys.file_exists search) then (
			prerr_string ("Error: " ^ search ^ " is not exist!\n\n");
			exit 1
		);
		let fdr = Fdr.of_sfp (ast_of_file init) (ast_of_file goal) in
		(* save FDR to sas_file *)
		let channel = open_out sas_file in
		output_string channel (Fdr.string_of fdr);
		close_out channel;
		(* invoke preprocessor *)
		let cmd = preprocessor ^ " < " ^ sas_file in
		if not ((Sys.command cmd) = 0) then (
			prerr_string "Error: preprocessor failed\n\n";
			exit 1
		);
		(* invoke search *)
		let cmd = search ^ " " ^ search_options ^ " < output" in
		if not ((Sys.command cmd) = 0) then (
			prerr_string "Error: search failed\n\n";
			exit 1
		);
		let plan =
			(* read plan_file *)
			if Sys.file_exists plan_file then (
				let channel = open_in plan_file in
				let n       = in_channel_length channel in
				let s       = String.create n in
				really_input channel s 0 n;
				close_in channel;
				let plan = Fdr.to_sfp_plan s fdr in
				let plan = Plan.parallel_of plan in
				"\n\nSolution plan:\n" ^ (Plan.json_of_parallel plan)
			)
			else "No solution!"
		in
		if debug then
			plan
		else
			try
				let files = [sas_file; "plan_numbers_and_cost"; "output";
					plan_file]
				in
				List.iter(fun file -> Sys.remove file) files;
				plan
			with
				e -> plan
	with
		Not_found ->
			prerr_string ("Error: environment variable FD_PREPROCESS" ^
				" or FD_SEARCH is not defined.\n\n");
			exit 1
;;

let usage_msg = "usage: csfp [options]\n\nwhere [options] are:" ;;
let opt_ast = ref "" ;;
let opt_ast_json = ref "" ;;
let opt_type = ref "" ;;
let opt_json = ref "" ;;
let opt_yaml = ref "" ;;
let opt_fs = ref "" ;;
let opt_init_file = ref "" ;;
let opt_goal_file = ref "" ;;
let opt_fdr = ref false ;;
let opt_fd = ref false ;;
let opt_apply_global = ref "" ;;

(**
 * main function
 *)
let main =
	let speclist = [
			("-json", Arg.Set_string opt_json,
				" Compile and print the result in JSON (default).");
			("-yaml", Arg.Set_string opt_yaml,
				" Compile and print the result in YAML.");
			("-ast",  Arg.Set_string opt_ast,
				"  Print abstract syntax tree.");
			("-ast-json", Arg.Set_string opt_ast_json,
				"Print the JSON of the abstract syntax tree.");
			("-type", Arg.Set_string opt_type,
				" Evaluate and print the element types.");
			("-fs",   Arg.Set_string opt_fs,
				"   Compile and print the flat store.");
			("-init", Arg.Set_string opt_init_file,
				" File specification of initial state.");
			("-goal", Arg.Set_string opt_goal_file,
				" File specification of goal state.");
			("-fdr",  Arg.Set opt_fdr,
				"  Generate and print Finite Domain Representation (FDR);" ^
				"\n         " ^
				"-init <file1.sfp> -goal <file2.sfp> must be provided.");
			("-fd",   Arg.Set opt_fd,
				"   Solve an SFP task. Options -init <init.sfp> -goal " ^
				"<goal.sfp>" ^
			 	"\n         " ^
				"must be provided. Environment variable FD_PREPROCESS & " ^
				"FD_SEARCH" ^
			 	"\n         " ^
				"must be set. Define FD_OPTIONS to pass options to the " ^
				"search engine." ^
			 	"\n         " ^
				"Define FD_DEBUG to keep all output files.");
			("-g", Arg.Set_string opt_apply_global,
				"    Check if the specification satisfies the global constraints.")
		]
	in
	Arg.parse speclist print_endline usage_msg;

	let do_compile = fun mode file ->
		let store = Valuation.sfpSpecification (ast_of_file file) in
		match mode with
		| 1 -> print_endline (Domain.json_of_store store)
		| 2 -> print_endline (Domain.yaml_of_store store)
		| 3 -> let fs = Domain.normalise store in
		       print_endline (Domain.string_of_flatstore fs)
		| _ -> print_endline usage_msg
	in
	let verify_files () =
		if !opt_init_file = "" then (
			print_endline "Error: -init <file.sfp> is not set";
			exit 1
		);
		if !opt_goal_file = "" then (
			print_endline "Error: -goal <file.sfp> is not set";
			exit 1
		);
	in	
	if !opt_json <> "" then do_compile 1 !opt_json;
	if !opt_yaml <> "" then do_compile 2 !opt_yaml;
	if !opt_fs <> "" then do_compile 3 !opt_fs;
	if !opt_ast <> "" then (
		print_endline (Syntax.string_of_sfp (ast_of_file !opt_ast))
	);
	if !opt_ast_json <> "" then (
		print_endline (Syntax.json_of_sfp (ast_of_file !opt_ast_json))
	);
	if !opt_type <> "" then
		print_endline (Type.string_of_map
			(Type.sfpSpecification (ast_of_file !opt_type))
		);
	if !opt_fdr then (
		verify_files();
		let fdr = Fdr.of_sfp (ast_of_file !opt_init_file) (ast_of_file
			!opt_goal_file)
		in
		print_endline (Fdr.string_of fdr)
	);
	if !opt_fd then (
		verify_files();
		print_endline (fd_plan !opt_init_file !opt_goal_file)
	);
	if !opt_apply_global <> "" then (
		let store =
			Valuation.sfpSpecification (ast_of_file !opt_apply_global)
		in
		match Domain.find store ["global"] with
		| Domain.Undefined ->
			print_endline "global constraints are satisfied"
		| Domain.Val (Domain.Global gc) when Constraint.apply store gc ->
			print_endline "global constraints are satisfied"
		| _ ->
			prerr_endline "global constraints are not satisfied"
	);
	
	if (Array.length Sys.argv) < 2 then Arg.usage speclist usage_msg
;;

let _ = main ;;
