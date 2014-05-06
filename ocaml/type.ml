(*
 * semantics type domains
 *)
type ttype   = T of string
            | TRef of ttype
            | TVec of ttype
            | TCons
            | TAction
            | TUndefined
and tcell   = Var of string list * ttype
            | Subtype of ttype * ttype
            | Type of ttype
and tenv    = tcell list

let rec is_defined (s : tenv) (t : ttype) =
  match s with
  | [] -> false
  | head :: tail ->
      match head with
      | Type t1 -> if t = t1 then true else is_defined tail t
      | _ -> is_defined tail t

and define (s : tenv) (t : ttype) =
  if is_defined s t then s else (Type t) :: s

and is_subtype (s : tenv) (t1 : ttype) (t2 : ttype) =
  match s with
  | [] -> false
  | head :: tail ->
      match head with
      | Subtype (t3, t4) -> if t1 = t3 && t2 = t4 then true else is_subtype tail t1 t2
      | _ -> is_subtype tail t1 t2

and set_subtype (s : tenv) (t1 : ttype) (t2 : ttype) =
  if is_subtype s t1 t2 then s else (Subtype (t1, t2)) :: s

and typeof (s : tenv) (var : string list) =
  match s with
  | [] -> TUndefined
  | head :: tail ->
      match head with
      | Var (v, t) -> if v = var then t else typeof tail var
      | _ -> typeof tail var

and settype (s : tenv) (var : string list) (t : ttype) =
  let tvar = typeof s var in
  match tvar with
  | TUndefined -> (Var (var, t)) :: s
  | _ -> if is_subtype s t tvar then s
         else raise (Failure ("incompatible type " ^ (Domain.string_of_ref var) ^ ":" ^ (string_of_type tvar) ^ " < " ^ (string_of_type t)))

and string_of_type (t : ttype) =
  match t with
  | T id -> id
  | TRef t1 -> "ref " ^ string_of_type t1
  | TVec t1 -> "[] " ^ string_of_type t1
  | TCons -> "constraint"
  | TAction -> "action"
  | TUndefined -> "undefined"
