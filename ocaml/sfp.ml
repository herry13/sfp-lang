(* Author: Herry (herry13@gmail.com) *)

open Array
open Common

let usage_msg =
    "Usage: sfp [options] <spec-file>\n" ^
    "       sfp -f <init_file> <goal_file>\n" ^
    "       sfp -p <init_file> <goal_file>\n"
;;

let usage_msg_with_options =
    usage_msg ^ "\nwhere [options] are:"
;;

(* options *)
let opt_verbose = ref false ;;
let opt_check_syntax = ref false ;;
let opt_check_type = ref false ;;
let opt_no_main = ref false ;;
let opt_fdr = ref false ;;
let opt_planning = ref false ;;
let opt_not_eval_global_constraints = ref false ;;

let files : string list ref = ref [] ;;

let evaluate_global_constraints store =
    match Domain.find store ["global"] with
    | Domain.Undefined -> true
    | Domain.Val (Domain.Global g) -> Constraint.apply store g
    | _ -> false
;;

let generate_json file =
    let mainReference =
        if !opt_no_main then []
        else ["main"]
    in
    let ast = Parser_helper.ast_of_file file in
    let types = Type.sfpSpecification ~main:mainReference ast in
    let store = Valuation.sfpSpecification ~main:mainReference ast in
    if not !opt_not_eval_global_constraints &&
       not (evaluate_global_constraints store) then (
        prerr_endline "Error: the specification violates the global constraints.";
        exit 1
    );
    print_endline (Json.of_store types store)
;;

let check_type file =
    let mainReference =
        if !opt_no_main then []
        else ["main"]
    in
    print_endline (Type.string_of_map (Type.sfpSpecification
        ~main:mainReference (Parser_helper.ast_of_file file)))
;;

let fd_plan init goal =
    let fd_preprocessor = "FD_PREPROCESS" in
    let fd_search       = "FD_SEARCH" in
    let fd_option       = "FD_OPTIONS" in
    let fd_debug        = "FD_DEBUG" in
    let sas_file        = "output.sas" in
    let plan_file       = "sas_plan" in
    let default_search_options = "--search \"lazy_greedy(ff())\"" in
    let out_files =
        [sas_file; "plan_numbers_and_cost"; "output"; plan_file]
    in
    try
        let preprocessor   = Sys.getenv fd_preprocessor in
        let search         = Sys.getenv fd_search in
        let search_options =
            try
                Sys.getenv fd_option
            with
            | e -> default_search_options
        in
        let debug =
            try
                let _ = Sys.getenv fd_debug in
                true
            with
            | e -> false
        in
        if not (Sys.file_exists preprocessor) then (
            prerr_string ("Error: " ^ preprocessor ^ " is not exist!\n\n");
            exit 1
        );
        if not (Sys.file_exists search) then (
            prerr_string ("Error: " ^ search ^ " is not exist!\n\n");
            exit 1
        );
        (* generate FDR *)
        let fdr = Fdr.of_sfp (Parser_helper.ast_of_file init)
            (Parser_helper.ast_of_file goal)
        in
        (* save FDR to sas_file *)
        write_file sas_file (Fdr.string_of fdr);
        (* invoke preprocessor *)
        let cmd = if !opt_verbose then preprocessor ^ "<" ^ sas_file
                  else preprocessor ^ "<" ^ sas_file ^ ">>output.log"
        in
        if not ((Sys.command cmd) = 0) then (
            prerr_string "Error: preprocessor failed\n\n";
            exit 1
        );
        (* invoke search *)
        let cmd =
            if !opt_verbose then search ^ " " ^ search_options ^ "<output"
            else search ^ " " ^ search_options ^ "<output>>output.log"
        in
        if not ((Sys.command cmd) = 0) then (
            prerr_string "Error: search failed\n\n";
            exit 1
        );
        (* read 'plan_file' *)
        let plan = if Sys.file_exists plan_file then read_file plan_file
                   else "null"
        in
        let plan = Plan.json_of_parallel (Plan.parallel_of
            (Fdr.to_sfp_plan plan fdr))
        in
        if not debug then (
            try
                List.iter (fun f -> Sys.remove f) out_files
            with _ -> ()
        );
        plan
    with
        Not_found ->
            prerr_string ("Error: environment variable FD_PREPROCESS" ^
                " or FD_SEARCH is not defined.\n\n");
            exit 1
;;


(** main function **)
let main =
    let options = [
        ("-x", Arg.Set opt_check_syntax,
            "    Check syntax.");
        ("-t", Arg.Set opt_check_type,
            "    Check type.");
        ("-m", Arg.Set opt_no_main,
            "    Do not extract main object.");
        ("-g", Arg.Set opt_not_eval_global_constraints,
            "    Do not evaluate global constraints.");
        ("-d", Arg.Set opt_fdr,
            "    Generate Finite Domain Representation.");
        ("-p", Arg.Set opt_planning,
            "    Planning.");
    ]
    in
    Arg.parse options (fun f -> files := f :: !files) usage_msg_with_options;

    try
        if !opt_check_syntax then
            List.iter (fun f ->
                let _ = Parser_helper.ast_of_file f in
                ()
            ) !files
        else if !opt_check_type then (
            opt_check_syntax := false;
            List.iter (fun f -> check_type f) !files
        )
        else if !opt_fdr then (
            match !files with
            | init :: goal :: [] ->
                print_endline (Fdr.string_of (Fdr.of_files init goal))
            | _ -> prerr_endline "Usage: sfp -f <init_file> <goal_file>"
        )
        else if !opt_planning then (
            match !files with
            | init :: goal :: [] -> print_endline (fd_plan init goal)
            | _ -> prerr_endline "Usage: sfp -p <init_file> <goal_file>"
        )
        else (
            match !files with
            | [] -> prerr_endline usage_msg
            | _  -> List.iter (fun f -> generate_json f) !files
        )
    with
    | Parser_helper.ParseError (f, l, p, t) ->
        prerr_endline (Parser_helper.string_of_parse_error
            (Parser_helper.ParseError (f, l, p, t)))
    | Domain.SfError (_, msg)
    | Type.TypeError (_, msg) -> prerr_endline msg
;;

let _ = main ;;
