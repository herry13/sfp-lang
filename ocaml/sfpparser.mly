%{

open Domain

let ref_main = []

%}

%token <bool> BOOL
%token <int> INT
%token <float> FLOAT
%token <string> STRING
%token <string> ID
%token <string> INCLUDE
%token <string list -> Domain.store -> Domain.store> SFP_INCLUDE
%token NULL
%token SCHEMA ISA GLOBAL
%token MERGE EXTENDS
%token COMMA DATA BEGIN END SEP LBRACKET RBRACKET EOS EOF
%token EQ NEQ IN IF ELSE

%start sfp included  /* entry points: sfp -> main file, included -> included file */
%type <Domain.store> sfp
%type <string list -> Domain.store -> Domain.store> included

%%
sfp:
    | statements EOF {
                       let s = $1 [] [] in
                       let v = find s ref_main in
                       match v with
                       | Val (Store main) -> main
                       | _ -> raise (Failure "[err7]")
                     }

included:
    | statements EOF   { $1 }

statements:
    | SCHEMA schema statements  { fun ns s -> $3 ns ($2 ns s) }
    /*| GLOBAL _constraint        { $1 }*/
    | body statements           { fun ns s -> $2 ns ($1 ns s) }
    |                           { fun ns s -> s }
/*
_constraint:
    | BEGIN c_and END

c_and:
    | c_equals      
    | c_not_equals

c_equals:
    | reference EQ basic EOS

c_not_equals:
    | reference NEQ basic EOS
*/
schema:
    | ID parent BEGIN body END  { fun ns s -> let r = [$1] in
                                              $4 r ($2 r s) }

parent:
    | EXTENDS ID  { fun r s -> inherit_proto (bind s r (Store [])) [] [$2] r }
    |             { fun r s -> bind s r (Store []) }

body:
    | assignment body     { fun ns s -> $2 ns ($1 ns s) }
    | SFP_INCLUDE         { $1 }
    |                     { fun ns s -> s }

assignment:
    | MERGE reference value {
                              fun ns s -> let (ns1, v1) = resolve s ns $2 in
                                          match v1 with
                                          | Undefined -> raise (Failure "[err9] cannot merge with undefined value")
                                          | _ -> $3 ns (List.append ns1 $2) s
                            }
    | reference value       { fun ns s -> $2 ns (List.append ns $1) s }

value:
	| EQ basic EOS
      { fun ns r s -> bind s r $2 }
    | isa EXTENDS prototypes
      { fun ns r s -> $3 ns r ($1 r s) }
    | link_reference EOS
      {
        fun ns r s -> let (_, v1) = resolve s ns $1 in
                      match v1 with
                      | Undefined -> raise (Failure "[err5]")
                      | Val v -> bind s r v
      }
    | isa BEGIN body END  /* syntactic sugar */
      { fun ns r s -> $3 r ($1 r s) }

isa:
	| ISA ID  { fun r s -> inherit_proto (bind s r (Store [])) [] [$2] r }
	|         { fun r s -> bind s r (Store []) }

prototypes:
    | prototype COMMA prototypes { fun ns r s -> $3 ns r ($1 ns r s) }
    | prototype                  { $1 }

prototype:
    | BEGIN body END    { fun ns r s -> $2 r s }
    | reference         { fun ns r s -> inherit_proto s ns $1 r }

basic:
    | BOOL                  { Bool $1 }
    | INT                   { Num (Int $1) }
    | FLOAT                 { Num (Float $1) }
    | data_reference        { Ref $1 }
    | STRING                { Str $1 }
    | NULL                  { Null }
    | vectors               { Vec $1 }

vectors:
    | LBRACKET items RBRACKET     { $2 }

items:
    | basic COMMA items     { $1 :: $3 }
    | basic                 { [$1] }

link_reference:
    | reference   { $1 }

data_reference:
    | reference   { $1 }

reference:
    | ID SEP reference  { $1 :: $3 }
    | ID                { [$1] }

%%
