(* register ocaml functions needed by ruby-ocaml *)
let _ =
  let r = Callback.register in
    (* used when mapping OCaml exceptions to Ruby *)
    r "Printexc.to_string" Printexc.to_string;
    r "Array.to_list" Array.to_list;
    r "Array.of_list" Array.of_list;
    r "Big_int.big_int_of_string" Big_int.big_int_of_string;
    r "Big_int.string_of_big_int" Big_int.string_of_big_int;
    ()

