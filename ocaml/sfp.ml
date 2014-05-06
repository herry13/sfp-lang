open Array

(* help *)
let help = "usage: sfp [option] <sfp-file>" ^
  "\n\nwhere [option] is:" ^
  "\n  -json   print output in JSON" ^
  "\n  -yaml   print output in YAML" ^
  "\n  -xml    print output in XML\n\n"

(* The Lexstack type. *)
type 'a t =
  {
    mutable stack : (string * in_channel * Lexing.lexbuf) list;
    mutable filename : string;
    mutable chan : in_channel;
    mutable lexbuf : Lexing.lexbuf;
    lexfunc : Lexing.lexbuf -> 'a;
  }

(*
 * Create a lexstack with an initial top level filename and the lexer function
 *)
let create top_filename lexer_function =
  let chan = open_in top_filename in
  {
    stack = [];
    filename = top_filename;
    chan = chan;
    lexbuf = Lexing.from_channel chan;
    lexfunc = lexer_function
  }

(* Get the current lexeme. *)
let lexeme ls = Lexing.lexeme ls.lexbuf

(* Get filename, line number and column number of current lexeme. *)
let current_pos ls =
  let pos = Lexing.lexeme_end_p ls.lexbuf in
  let linepos = pos.Lexing.pos_cnum - pos.Lexing.pos_bol - String.length (Lexing.lexeme ls.lexbuf) in
  ls.filename, pos.Lexing.pos_lnum, linepos

let dummy_lexbuf = Lexing.from_string ""

(*
 * The next token need to accept an unused dummy lexbuf so that
 * a closure consisting of the function and a lexstack can be passed
 * to the ocamlyacc generated parser.
 *)
let rec get_token ls dummy_lexbuf =
  let token = ls.lexfunc ls.lexbuf in
  match token with
  | Sfpparser.INCLUDE file -> (* parse included file *)
      Sfpparser.SFP_INCLUDE (
        fun ns s -> let lexstack = create file Sfplexer.token in
                    try 
                      Sfpparser.included (get_token lexstack) dummy_lexbuf ns s
                    with e -> check_error e lexstack
      )
  | Sfpparser.EOF ->
      ( match ls.stack with
        | [] -> Sfpparser.EOF
        | (fn, ch, lb) :: tail ->
            ls.filename <- fn;
            ls.chan <- ch;
            ls.stack <- tail;
            ls.lexbuf <- lb;
            get_token ls dummy_lexbuf
      )
  | _ -> token

and check_error e lexstack =
  match e with
  | Parsing.Parse_error ->
      let fname, lnum, lpos = current_pos lexstack in
      let errstr = Printf.sprintf
        "\n\nFile '%s' line %d, column %d : current token is '%s'.\n\n"
        fname lnum lpos (lexeme lexstack) in
      raise (Failure errstr)
  | e -> raise e

(* parse main file *)
and parse file =
  let lexstack = create file Sfplexer.token in
  try 
    Sfpparser.sfp (get_token lexstack) dummy_lexbuf
  with e -> check_error e lexstack



let compile opt file =
  let result = parse file in
  if opt = "-yaml" then print_string (Domain.yaml_of_store result)
  (*else if opt = "-xml" then print_string (Domain.xml_of_store result)*)
  else print_string (Domain.json_of_store result);
  print_newline()

let _ =
  if (length Sys.argv) < 2 then print_string help
  else if Sys.argv.(1) = "-h" || Sys.argv.(1) = "--help" then print_string help
  else if (length Sys.argv) >= 3 then compile Sys.argv.(1) Sys.argv.(2)
  else compile "" Sys.argv.(1)
