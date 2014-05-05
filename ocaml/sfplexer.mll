{
  open Sfpparser

  let create_string s = String.sub s 1 ((String.length s) - 2)

  let get_include_file s = create_string (String.trim (String.sub s 8 ((String.length s) - 9)))
}
rule token = parse
	  [' ''\t''\n''\r']                           { token lexbuf } (* skip blanks *)
    | "//"[^'\n''\r']*                            { token lexbuf } (* skip inline comment *)
    | '/' '*'+ (('*'[^'/'])+|[^'*']+)* '*'+ '/'   { token lexbuf } (* skip multi-lines comment *)
	| '-'?['0'-'9']+ as i                         { INT(int_of_string i) }
    | '-'?['0'-'9']+ '.' ['0'-'9']* as f          { FLOAT(float_of_string f) }
	| ("true"|"yes")                              { BOOL true }
	| ("false"|"no")                              { BOOL false }
    | "null"                                      { NULL }
    | '"'('\\'_|[^'\\''"'])*'"' as s              { STRING (create_string s) }
    | "extends"                                   { EXTENDS }
	| ("#include"|"include")[' ''\t']+ '"'('\\'_|[^'\\''"'])+'"' [' ''\t']* ';' as s
      { INCLUDE (get_include_file s) } (* return included file name *)
    | "++"                                        { MERGE }
    | ','                                         { COMMA }
    | '{'                                         { BEGIN }
    | '}'                                         { END }
    | '['                                         { LBRACKET }
    | ']'                                         { RBRACKET }
    | ("="|"is")                                  { EQ }
    | ("!="|"isnt")                               { NEQ }
    | "in"                                        { IN }
    | "if"                                        { IF }
    | "else"                                      { ELSE }
	| ';'                                         { EOS } (* end of assignment *)
    | '.'                                         { SEP } (* identifiers' separator *)
	| ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '_' '0'-'9']* as id    { ID id }
	| eof                                         { EOF }
