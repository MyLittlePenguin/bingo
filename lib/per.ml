let gen_list n =
  let rec aux acc n = if n > 0 then aux (n :: acc) (n - 1) else acc in
  aux [] n

let insert_at lst pos it =
  let rec aux acc lst pos it =
    match (lst, pos) with
    | [], 0 -> it :: acc
    | [], _ -> acc
    | lst, 0 -> aux (it :: acc) lst (pos - 1) it
    | hd :: tl, _ -> aux (hd :: acc) tl (pos - 1) it
  in
  aux [] lst pos it |> List.rev

let add_mutations lst new_item =
  let current_length =
    if List.length lst = 0 then 0 else List.hd lst |> List.length
  in
  let rec gen_new_permutations acc base new_item pos =
    let new_acc = insert_at base pos new_item :: acc in
    if pos = 0 then new_acc
    else gen_new_permutations new_acc base new_item (pos - 1)
  in
  let rec aux lst acc =
    match lst with
    | [] -> [ new_item ] :: acc
    | hd :: [] -> gen_new_permutations acc hd new_item current_length
    | hd :: tl -> gen_new_permutations acc hd new_item current_length |> aux tl
  in
  aux lst []

let cut_off length list = List.map (fun it -> List.take length it) list

let bingo_row acc it = add_mutations acc it |> cut_off 5

let bingo lst =
  List.fold_left bingo_row [] lst

let mutate lst = List.fold_left (add_mutations) [] lst
