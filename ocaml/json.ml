(* Author: Herry (herry13@gmail.com)
   Serialisation/Deserialisation to/from JSON *)

open Common
open Domain

exception JsonError of int * string

let error code msg = raise (JsonError (code, msg)) ;;

let (!^) r = String.concat "." r ;;

let of_basic_type t = match t with
	| Syntax.TBool -> "bool"
	| Syntax.TInt -> "int"
	| Syntax.TFloat -> "float"
	| Syntax.TStr -> "str"
	| Syntax.TObject -> "object"
	| Syntax.TSchema (id, _) -> id
	| _ -> error 1301 "invalid basic type"
;;

let rec of_type t = match t with
	| Syntax.TBasic t -> of_basic_type t
	| Syntax.TVec t -> "[]" ^ (of_type t)
	| Syntax.TRef t -> "$" ^ (of_basic_type t)
	| _ -> error 1302 "invalid type"
;;

(** private function to generate JSON of basic value **)
let rec json_basic_value buf v =
	let json_vector vector =
		let rec iter vec = match vec with
			| [] -> ()
			| head :: [] -> json_basic_value buf head
			| head :: tail -> (
					json_basic_value buf head;
					Buffer.add_char buf ',';
					iter tail
				)
		in
		Buffer.add_char buf '[';
		iter vector;
		Buffer.add_char buf ']'
	in
	match v with
	| Domain.Boolean b -> Buffer.add_string buf (string_of_bool b)
	| Domain.Int i     -> Buffer.add_string buf (string_of_int i)
	| Domain.Float f   -> Buffer.add_string buf
	                          (Yojson.Basic.to_string (`Float f))
	| Domain.String s  -> Buffer.add_string buf
	                          (Yojson.Basic.to_string (`String s))
	| Domain.Null      -> Buffer.add_string buf "null"
	| Domain.Ref r     -> (
			Buffer.add_string buf "\"$";
			Buffer.add_string buf !^r;
			Buffer.add_char buf '"'
		)
	| Domain.Vector vec -> json_vector vec
    | Domain.EnumElement (name, element) -> (
            Buffer.add_string buf "\"%";
            Buffer.add_string buf name;
            Buffer.add_char buf '.';
            Buffer.add_string buf element;
            Buffer.add_char buf '"'
        )
;;

let of_basic_value v =
	let buf = Buffer.create 42 in
	json_basic_value buf v;
	Buffer.contents buf
;;

let rec json_constraint buf c =
	match c with
	| Domain.Eq (r, v) -> (
			constraint_left_side buf "=" r;
			json_basic_value buf v;
			Buffer.add_char buf ']'
		)
	| Domain.Ne (r, v) -> (
			constraint_left_side buf "!=" r;
			json_basic_value buf v;
			Buffer.add_char buf ']'
		)
	| Domain.Greater (r, v) -> (
			constraint_left_side buf ">" r;
			json_basic_value buf v;
			Buffer.add_char buf ']'
		)
	| Domain.GreaterEqual (r, v) -> (
			constraint_left_side buf ">=" r;
			json_basic_value buf v;
			Buffer.add_char buf ']'
		)
	| Domain.Less (r, v) -> (
			constraint_left_side buf "<" r;
			json_basic_value buf v;
			Buffer.add_char buf ']'
		)
	| Domain.LessEqual (r, v) -> (
			constraint_left_side buf "<=" r;
			json_basic_value buf v;
			Buffer.add_char buf ']'
		)
	| Domain.In (r, vec) -> (
			constraint_left_side buf "in" r;
			json_basic_value buf (Domain.Vector vec);
			Buffer.add_char buf ']'
		)
	| Domain.Not c -> (
			constraint_label buf "not";
			Buffer.add_char buf ',';
			json_constraint buf c;
			Buffer.add_char buf ']'
		)
	| Domain.Imply (c1, c2) -> (
			constraint_label buf "imply";
			Buffer.add_char buf ',';
			json_constraint buf c1;
			Buffer.add_char buf ',';
			json_constraint buf c1;
			Buffer.add_char buf ']'
		)
	| Domain.And []
	| Domain.Or  [] -> Buffer.add_string buf "true"
	| Domain.And cs -> (
			constraint_label buf "and";
			List.iter (fun c ->
				Buffer.add_char buf ',';
				json_constraint buf c
			) cs;
			Buffer.add_char buf ']'
		)
	| Domain.Or cs -> (
			constraint_label buf "or";
			List.iter (fun c ->
				Buffer.add_char buf ',';
				json_constraint buf c
			) cs;
			Buffer.add_char buf ']'
		)
	| Domain.True -> Buffer.add_string buf "true"
	| Domain.False -> Buffer.add_string buf "false"
and constraint_label buf operator =
	Buffer.add_string buf "[\"";
	Buffer.add_string buf operator;
	Buffer.add_char buf '"'
and constraint_left_side buf operator r =
	constraint_label buf operator;
	Buffer.add_string buf ",\"";
	Buffer.add_string buf !^r;
	Buffer.add_string buf "\","
;;

let of_constraint c =
	let buf = Buffer.create 42 in
	json_constraint buf c;
	Buffer.contents buf
;;

let add_ident ?_type:(t="") buf id =
	Buffer.add_char buf '"';
	Buffer.add_string buf id;
	if t <> "" then (
		Buffer.add_char buf ':';
		Buffer.add_string buf t
	);
	Buffer.add_string buf "\":"

let json_action buf (_, parameters, cost, conditions, effects) =
	(* parameters *)
	let rec json_parameters ps = match ps with
		| [] -> ()
		| (id, t) :: [] -> (
				add_ident buf id;
				Buffer.add_char buf '"';
				Buffer.add_string buf (of_type t);
				Buffer.add_char buf '"'
			)
		| (id, t) :: tail -> (
				add_ident buf id;
				Buffer.add_char buf '"';
				Buffer.add_string buf (of_type t);
				Buffer.add_string buf "\",";
				json_parameters tail
			)
	in
	Buffer.add_string buf "{\".type\":\"action\",\"parameters\":{";
	json_parameters parameters;
	Buffer.add_string buf "},\"cost\":";
	(* cost *)
	Buffer.add_string buf (string_of_int cost);
	(* conditions *)
	Buffer.add_string buf ",\"conditions\":";
	json_constraint buf conditions;
	(* effects *)
	let rec json_effects effs = match effs with
		| [] -> ()
		| (r, v) :: [] -> (
				constraint_left_side buf "=" r;
				json_basic_value buf v;
				Buffer.add_char buf ']'
			)
		| (r, v) :: tail -> (
				constraint_left_side buf "=" r;
				json_basic_value buf v;
				Buffer.add_char buf ',';
				json_effects tail;
				Buffer.add_char buf ']'
			)
	in
	Buffer.add_string buf ",\"effects\":";
	Buffer.add_char buf '[';
	json_effects effects;
	Buffer.add_string buf "]}"
;;

let rec of_value value =
	let buf = Buffer.create 42 in
	(
		match value with
		| Domain.Basic bv -> json_basic_value buf bv
		| Domain.Link r -> (
				Buffer.add_string buf "\"§";
				Buffer.add_string buf !^r;
				Buffer.add_char buf '"'
			)
		| Domain.TBD -> Buffer.add_string buf "\"$TBD\""
		| Domain.Unknown -> Buffer.add_string buf "\"$unknown\""
		| Domain.Nothing -> Buffer.add_string buf "\"$nothing\""
		| Domain.Store child -> Buffer.add_string buf "{}"
		| Domain.Global c -> json_constraint buf c
		| Domain.Action a -> json_action buf a
        | Domain.Enum _ -> Buffer.add_string buf ("\"%enum\"")
	);
	Buffer.contents buf
;;

let of_store typeEnv store =
	let buf = Buffer.create 42 in
	let json_variable_type ns id =
		let r = Domain.(@+.) ns id in
		match MapRef.find r typeEnv with
		| Syntax.TUndefined -> error 1303 ("type of " ^ !^r ^ " is undefined")
		| t -> of_type t
	in
	let set_json_object_type ns id =
		let r = Domain.(@+.) ns id in
		match MapRef.find r typeEnv with
		| Syntax.TUndefined -> error 1304 ("type of " ^ !^r ^ " is undefined")
		| Syntax.TBasic Syntax.TSchema (id, Syntax.TRootSchema) ->
			Buffer.add_string buf "\".type\":\"schema\""
		| Syntax.TBasic Syntax.TSchema (id, super) -> (
				Buffer.add_string buf "\".type\":\"schema\",\".super\":\"";
				Buffer.add_string buf (of_type (Syntax.TBasic super));
				Buffer.add_char buf '"'
			)
		| t -> (
				Buffer.add_string buf "\".type\":\"";
				Buffer.add_string buf (of_type t);
				Buffer.add_char buf '"'
			)
	in
	let rec json_store ns s = match s with
		| [] -> ()
		(* | (id, v) :: [] -> json_cell ns id v *)
		| (id, v) :: tail -> (
			Buffer.add_char buf ',';
				json_cell ns id v;
				json_store ns tail
			)
	and json_cell ns id v = match v with
		| Domain.Basic Domain.Null -> (
				add_ident ~_type:(json_variable_type ns id) buf id;
				json_basic_value buf Domain.Null
			)
		| Domain.Basic (Domain.Vector vec) -> (
				add_ident ~_type:(json_variable_type ns id) buf id;
				json_basic_value buf (Domain.Vector vec)
			)
		| Domain.Basic bv -> (
				add_ident buf id;
				json_basic_value buf bv
			)
		| Domain.Link r -> (
				add_ident buf id;
				Buffer.add_string buf "\"§";
				Buffer.add_string buf !^r;
				Buffer.add_char buf '"'
			)
		| Domain.TBD -> (
				add_ident ~_type:(json_variable_type ns id) buf id;
				Buffer.add_string buf "\"$TBD\""
			)
		| Domain.Unknown -> (
				add_ident ~_type:(json_variable_type ns id) buf id;
				Buffer.add_string buf "\"$unknown\""
			)
		| Domain.Nothing -> (
				add_ident ~_type:(json_variable_type ns id) buf id;
				Buffer.add_string buf "\"$nothing\""
			)
		| Domain.Store child -> (
				add_ident buf id;
				Buffer.add_char buf '{';
				set_json_object_type ns id;
				(* Buffer.add_string buf (json_variable_type ns id); *)
				json_store (Domain.(@+.) ns id) child;
				Buffer.add_char buf '}'
			)
		| Domain.Global c -> (
				add_ident buf id;
				json_constraint buf c
			)
		| Domain.Action a -> (
				add_ident buf id;
				json_action buf a
			)
        | Domain.Enum elements -> (
                add_ident buf id;
                Buffer.add_char buf '{';
                Buffer.add_string buf "\".type\":\"enum\",\"elements\":[\"";
                Buffer.add_string buf (String.concat "\",\"" elements);
                Buffer.add_string buf "\"]}"
            )
	in
	Buffer.add_string buf "{\".type\":\"object\"";
	json_store [] store;
	Buffer.add_char buf '}';
	Buffer.contents buf
;;

let of_flatstore flatstore =
	let buf = Buffer.create 42 in
    let first = ref true in
	Buffer.add_char buf '{';
	MapRef.iter (
		fun r v ->
            if !first then (
                Buffer.add_char buf '\n';
                first := false
            )
            else (
                Buffer.add_string buf ",\n"
            );
			Buffer.add_string buf "  \"";
			Buffer.add_string buf !^r;
			Buffer.add_string buf "\": ";
			Buffer.add_string buf (of_value v);
	) flatstore;
	Buffer.add_string buf "\n}";
	Buffer.contents buf
;;


(* TODO *)
let to_store json =
	let typeEnv = MapRef.empty in
	let store = [] in
	let reference_separator = Str.regexp "\\." in
	let rec make_vector acc vec =
		match vec with
		| []           -> acc
		| head :: tail -> (
				match sfp_of head with
				| Basic bv -> (make_vector (bv :: acc) tail)
				| _        -> error 1035 ""
			)
	and make_store acc s =
		match s with
		| []              -> acc
		| (id, v) :: tail -> make_store ((id, (sfp_of v)) :: acc) tail
	and sfp_of = function
		| `String str when (String.length str) > 2 &&
		                   str.[0] = '$' && str.[1] = '.' ->
			Basic (Ref (List.tl (Str.split reference_separator
				str)))
		| `String str -> Basic (String str)
		| `Bool b     -> Basic (Boolean b)
		| `Float f    -> Basic (Float f)
		| `Int i      -> Basic (Int i)
		| `Null       -> Basic Null
		| `List vec   -> Basic (Vector (make_vector [] vec))
		| `Assoc s    -> Store (make_store [] s)
	in
	let _ = sfp_of (Yojson.Basic.from_string json) in
	(typeEnv, store)
