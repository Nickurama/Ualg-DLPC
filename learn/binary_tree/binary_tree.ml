type 'a bin_tree =
    | Empty
    | Node of 'a bin_tree * 'a * 'a bin_tree

let rec count_nodes tree = match tree with
    | Empty -> 0
    | Node(left, _, right) -> 1 + count_nodes left + count_nodes right

let rec list_nodes tree = match tree with
    | Empty -> []
    | Node(left, value, right) -> list_nodes left @ [ value ] @ list_nodes right

let rec dfs tree = match tree with
    | Empty -> []
    | Node (left, value, right) -> dfs left @ value::(dfs right)

let rec print_list_values print_func list = match list with
    | [] -> ()
    | [x] -> print_func x
    | x :: xs -> print_func x; print_string ", "; print_list_values print_func xs

let rec print_list_values_iter print_func list = List.iter print_func list (* iter applies the function given to every element of the list *)

let print_list print_func = function list ->
    print_string "[";
    print_list_values list print_func;
    print_string "]";
    print_newline ()

let rec tree_height tree = match tree with
    | Empty -> 0
    | Node(left, _, right) ->
            let left_height = tree_height left in
            let right_height = tree_height right in
            let max_height = if (left_height < right_height) then right_height else left_height in
            max_height + 1

let rec tree_height tree = match tree with
    | Empty -> 0
    | Node(left, _, right) -> 1 + max (tree_height left) (tree_height right)

let rec print_ident ident = match ident with
    | 0 -> ()
    | 1 -> print_string "|-"
    | x -> print_string "| "; print_ident (ident - 1)

let rec print_tree_str print_func tree ident = match tree with
    | Empty -> ()
    | Node(left, value, right) ->
            (* print_string str; *)
            print_ident ident;
            print_func value;
            print_newline ();
            print_tree_str print_func left (ident + 1);
            print_tree_str print_func right (ident + 1)

let rec print_tree print_func tree = print_tree_str print_func tree 0




let example = Node(
    Node(
        Empty,
        2,
        Node(
            Empty,
            4,
            Empty
        )
    ),
    1,
    Node(
        Empty,
        3,
        Empty
    )
)

let () = Format.printf "Tree height: %d@." (tree_height example)
let () = Format.printf "Tree nodes: %d@." (count_nodes example)

let () = Format.printf "Node values: @?"
let () = print_list (list_nodes example) print_int 
let () = print_tree print_int example

