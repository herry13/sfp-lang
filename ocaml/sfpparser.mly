%{

open Domain

let ref_main = []
let ref_global = ["global"]

%}

%token <bool> BOOL
%token <int> INT
%token <float> FLOAT
%token <string> STRING
%token <string> ID
%token <string> INCLUDE
%token <string list -> Domain.store -> Domain.store> SFP_INCLUDE
%token NULL
%token SCHEMA ISA GLOBAL ACTION
%token MERGE EXTENDS
%token COMMA DATA BEGIN END SEP LB RB COLON LSBRACKET RSBRACKET EOS EOF
%token EQ NEQ IN IF THEN

%start sfp included    /* entry points: sf -> main file, included -> included file */
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
    | SFP_INCLUDE statements    { fun ns s -> $2 ns ($1 ns s) }
    | SCHEMA schema statements  { fun ns s -> $3 ns ($2 ns s) }
    | GLOBAL global statements
      {
        fun ns s -> let g = find s ref_global in
                    match g with
                    | Undefined | Val (Basic _) | Val (Store _) -> $3 ns (bind s ref_global (Cons $2))
                    | Val (Cons c) ->
                        match c, $2 with
                        | And c1, And c2 -> $3 ns (bind s ref_global (Cons (And (List.append c1 c2))))
                        | And c1, _ -> $3 ns (bind s ref_global (Cons (And (List.append c1 [$2]))))
                        | _, And c2 -> $3 ns (bind s ref_global (Cons (And (c :: c2))))
                        | _, _ -> $3 ns (bind s ref_global (Cons (And [c; $2])))
      }
    | assignment statements     { fun ns s -> $2 ns ($1 ns s) }
    |                           { fun ns s -> s }

global:
    | c_equals EOS        { $1 } 
    | c_not_equals EOS    { $1 }
    | c_inlist EOS        { $1 }
    | c_imply EOS         { $1 }
    | BEGIN c_and END     { And $2 }

c_and:
	| c_stmt EOS c_and  { $1 :: $3 }
	|                   { [] }

c_stmt:
    | c_equals         { $1 } 
    | c_not_equals     { $1 }
    | c_inlist         { $1 }
    | c_imply          { $1 }
    | BEGIN c_and END  { And $2 }

c_equals:
    | reference EQ basic  { Atom ($1, $3) }

c_not_equals:
    | reference NEQ basic { Neg (Atom ($1, $3)) }

c_inlist:
    | reference IN vector { In ($1, $3) }

c_imply:
    | IF c_stmt THEN c_stmt { Imply ($2, $4) }

schema:
    | ID parent BEGIN body END  { fun ns s -> let r = [$1] in $4 r ($2 r s) }

parent:
    | EXTENDS ID  { fun r s -> inherit_proto (bind s r (Store [])) [] [$2] r }
    |             { fun r s -> bind s r (Store []) }

body:
    | assignment body     { fun ns s -> $2 ns ($1 ns s) }
    | SFP_INCLUDE         { $1 }
    |                     { fun ns s -> s }

assignment:
    | reference value  {
                         fun ns s -> let r = $1 in
                                     let (ns1, v1) = resolve s ns (prefix r) in
                                     if (List.length r) = 1 then $2 ns (List.append ns r) s
                                     else match v1 with
                                          | Val (Store s1) -> $2 ns (List.append ns1 r) s
                                          | _ -> raise (Failure "[err6]")
                       }

value:
	| EQ basic EOS          { fun ns r s -> bind s r (Basic $2) }
    | obj                   { $1 }
    | link_reference EOS    {
                              fun ns r s -> let (_, v1) = resolve s ns $1 in
                                            match v1 with
                                            | Undefined -> raise (Failure "[err5]")
                                            | Val v -> bind s r v
                            }

obj:
    | ISA ID proto  { fun ns r s -> $3 ns r (inherit_proto (bind s r (Store [])) [] [$2] r) }
    | proto         { fun ns r s -> $1 ns r (bind s r (Store [])) }

proto:
    | EXTENDS prototypes  { $2 }
    | BEGIN body END      { fun ns r s -> $2 r s }

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
    | vector                { Vec $1 }

vector:
    | LSBRACKET items RSBRACKET     { $2 }

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
