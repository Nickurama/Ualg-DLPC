(* "*" is intersection, "|" is union *)

type intbintree =
    | Empty
    | Node of intbintree * int * intbintree (* Constructor with parameters (of) *)

let rec somatree t = match t with
    | Empty -> 0
    | Node (l, i, r) -> somatree l + somatree r + i

let rec cardinal t = match t with
    | Empty -> 0
    | Node (l, _, r) -> cardinal l + cardinal r + 1

type 'a bintree = (* generic type *)
    | Empty
    | Node of 'a bintree * 'a * 'a bintree
