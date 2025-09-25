(* reminder: () is of type "unit" *)

let (get, set, inc, reset) =
    let c = ref 0 in (* "pointer" c that points to value 0 *)
    let g () = !c in (* g returns what c points to *) (* g will have it's own copy of c, of course (what's called closure, "fecho") *)
    let s x = c := x in (* x is assigned to where c points to *)
    let i () = c := !c + 1 in (* increments 1 to the value c points to *)
    let r () = c := 0 in (* sets the value c points to to 0 *)
    (g, s, i, r) (* sets getm setm inc, reset to g, s, i, r *)

(* bootleg monad / data structure with private variable and accessor methods *)

let () = set 5
let x = get ()
let () = print_int x
