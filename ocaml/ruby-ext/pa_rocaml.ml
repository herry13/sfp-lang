
open Camlp4.PreCast

let module_name =
  let s = Sys.argv.(Array.length Sys.argv - 1) in
    String.capitalize (String.sub s 0 (String.rindex s '.'))
let namespace = ref module_name

let export _loc ids =
  let exprs = List.map
                (fun id ->
                   let name = !namespace ^ "." ^ id in
                     <:expr< Callback.register $str:name$ $lid:id$ >>)
                ids in
  <:str_item< do { $list:exprs$ } >>


EXTEND Gram
  Syntax.str_item: LEVEL "top" [
    [
      "export"; names = LIST1 [ x = LIDENT -> x ] SEP "," -> export _loc names
    | "export"; e = Syntax.expr; "aliased"; id = Syntax.expr ->
        let id = <:expr< $str:!namespace$ ^ "." ^ $id$ >> in
          <:str_item< do{ Callback.register $id$ $e$ } >>
    | "namespace"; n = STRING -> namespace := n; <:str_item< >>
    ]
  ];
END;;
