type 'a dyn_list = {
    mutable items : 'a list ref;
    mutable length : int;
}

let dl_create () = {
    items = ref [];
    length = 0;
}

let dl_push dl x =
    dl.items := x :: !(dl.items);
    dl.length <- dl.length + 1

let dl_get_list dl = List.rev !(dl.items)

let dl_length dl = dl.length
