/**
 * Author: Herry (herry13@gmail.com)
 *
 * This is a parser which generates an abstract syntax tree from a concrete
 * syntax tree.
 */

%{

open Syntax

%}

%token <string> BOOL
%token <string> INT
%token <string> FLOAT
%token <string> STRING
%token NULL TOK_TBD TOK_UNKNOWN TOK_NOTHING
%token <string> INCLUDE
%token <string> SFP_INCLUDE_FILE
%token <string> ID
%token EXTENDS COMMA DATA BEGIN END SEP
%token LBRACKET RBRACKET EOS EOF
%token ISA SCHEMA ASTERIX COLON TBOOL TINT TFLOAT TSTR TOBJ
%token GLOBAL EQUAL NOT_EQUAL IF THEN IN NOT LPARENTHESIS RPARENTHESIS
%token TOK_GREATER TOK_GREATER_EQUAL TOK_LESS TOK_LESS_EQUAL
%token COST CONDITIONS EFFECTS ACTION

/* entry point to included file */
%token <Syntax.block -> Syntax.block> SF_INCLUDE
%token <Syntax.context -> Syntax.context> SFP_INCLUDE

/* entry point for main-file is 'sfp', for included file is
   'incontext_included' or 'inblock_included' */
%start inblock_included sfp incontext_included
%type <Syntax.block -> Syntax.block> inblock_included
%type <Syntax.sfp> sfp
%type <Syntax.context -> Syntax.context> incontext_included

%%

sfp
	: sfpcontext EOF { $1 EmptyContext }

incontext_included
	: sfpcontext EOF { $1 }

sfpcontext
	: SCHEMA schema sfpcontext   { fun c -> SchemaContext ($2, $3 c) }
	| GLOBAL global sfpcontext   { fun c -> GlobalContext ($2, $3 c) }
	| SFP_INCLUDE EOS sfpcontext { fun c -> $1 ($3 c) }
	| assignment sfpcontext      { fun c -> AssignmentContext ($1, $2 c) }
	|                            { fun c -> c }

inblock_included
	: block EOF { $1 }

block
	: assignment block     { fun b -> AssignmentBlock ($1, $2 b) }
	| GLOBAL global block  { fun b -> GlobalBlock ($2, $3 b) }
	| SF_INCLUDE EOS block { fun b -> $1 ($3 b) }
	|                      { fun b -> b }

assignment
	: ACTION reference action  { ($2, TUndefined, $3) }
	| reference type_def value { ($1, $2, $3) }

value
	: EQUAL equal_value EOS  { $2 }
	| link_reference EOS     { Link $1 }
	| ISA ID protos          { Prototype (SID $2, $3) }
	| protos                 { Prototype (EmptySchema, $1) }

equal_value
	: basic       { Basic $1 }
	| TOK_TBD     { TBD }
	| TOK_UNKNOWN { Unknown }
	| TOK_NOTHING { Nothing }

protos
	: EXTENDS prototypes { $2 }
	| BEGIN block END    { BlockPrototype ($2 EmptyBlock, EmptyPrototype) }

prototypes
    : prototype COMMA prototypes { $1 $3 }
    | prototype                  { $1 EmptyPrototype }

prototype
    : BEGIN block END { fun p -> BlockPrototype ($2 EmptyBlock, p) }
    | reference       { fun p -> ReferencePrototype ($1, p) } 

basic
    : BOOL           { Boolean $1 }
    | INT            { Int $1 }
    | FLOAT          { Float $1 }
    | STRING         { String $1 }
    | data_reference { Reference $1 }
    | NULL           { Null }
    | vector         { Vector $1 }

vector
    : LBRACKET items RBRACKET { $2 }

items
    : basic COMMA items { $1 :: $3 }
    | basic             { [$1] }

link_reference
    : reference { $1 }

data_reference
    : reference { $1 }

reference
    : ID SEP reference { $1 :: $3 }
    | ID               { [$1] }

schema
	: ID super BEGIN block END { ($1, $2, $4 EmptyBlock) }

super
	: EXTENDS ID { SID $2 }
	|            { EmptySchema }

type_def
	: COLON ttype { $2 }
	|             { TUndefined }

ttype
	: LBRACKET RBRACKET ttype { TVec $3 }
	| ASTERIX tau             { TRef $2 }
	| tau                     { TBasic $1 }

tau
	: TBOOL  { TBool }
	| TINT   { TInt }
	| TFLOAT { TFloat }
	| TSTR   { TStr }
	| TOBJ   { TObject }
	| ID     { TSchema ($1, TObject) }

global
	: sfp_constraint { $1 }

conjunction
	: sfp_constraint conjunction { $1 :: $2 }
	|                            { [] }

disjunction
	: sfp_constraint disjunction { $1 :: $2 }
	|                            { [] }

sfp_constraint
	: BEGIN conjunction END                 { And $2 }
	| LPARENTHESIS disjunction RPARENTHESIS { Or $2 }
	| equal                                 { $1 }
	| equal_true                            { $1 }
	| not_equal                             { $1 }
	| negation                              { $1 }
	| implication                           { $1 }
	| membership                            { $1 }
	| greater_than                          { $1 }
	| less_than                             { $1 }
	| greater_equal                         { $1 }
	| less_equal                            { $1 }

equal
	: reference EQUAL basic EOS { Eq ($1, $3) }

equal_true
	: reference EOS { Eq ($1, Boolean "true") }

not_equal
	: reference NOT_EQUAL basic EOS { Ne ($1, $3) }

greater_than
	: reference TOK_GREATER basic EOS { Greater ($1, $3) }

greater_equal
	: reference TOK_GREATER_EQUAL basic EOS { GreaterEqual ($1, $3) }

less_than
	: reference TOK_LESS basic EOS { Less ($1, $3) }

less_equal
	: reference TOK_LESS_EQUAL basic EOS { LessEqual ($1, $3) }

implication
	: IF sfp_constraint THEN sfp_constraint { Imply ($2, $4) }

negation
	: NOT sfp_constraint { Not $2 }

membership
	: reference IN vector EOS { In ($1, $3) }

action
	: parameters BEGIN cost conditions EFFECTS BEGIN effects END END
		{ 
			Action ($1, $3, $4, $7)
		}

parameters
	: LPARENTHESIS params RPARENTHESIS { $2 }
	|                                  { [] }

params
	: param COMMA params { $1 :: $3 }
	| param              { [$1] }

param
	: ID COLON ttype { ($1, $3) }

cost
	: COST EQUAL INT EOS { Cost $3 }
	|                    { EmptyCost }

conditions
	: CONDITIONS sfp_constraint { Condition $2 }
	|                           { EmptyCondition }

effects
	: effect effects { $1 :: $2 }
	| effect         { [$1] }

effect
	: reference EQUAL basic EOS { ($1, $3) }

%%
