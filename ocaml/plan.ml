open Common
open Domain

type t = Action.t list
(* type Action.t = reference * basic MapStr.t * cost * basic MapRef.t * basic MapRef.t *)

let from_fast_downward (plan: string) : t =
    let newline = Str.regexp "\n" in
    let space = Str.regexp " " in
    let global = Str.regexp "^\\$\\.!global" in
    List.fold_left (fun acc s ->
        let parts = Str.bounded_split space s 3 in
        let name_params = List.tl parts in
        let name = List.hd name_params in
        if Str.string_match global name 0 then acc
        else (
            let r = reference_of_string name in
            let a = (r, MapStr.empty, 0, MapRef.empty, MapRef.empty) in
            a :: acc
        )
    ) [] (Str.split newline plan)

let to_string (plan: t) : string =
    List.fold_left (fun s (name, _, _, _, _) -> s ^ !^name ^ "\n") "" plan