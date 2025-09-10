open Permutations.Per

let row1 = gen_list 10 |> bingo
let row2 = gen_list 10 |> List.map ((+) 10) |> bingo 
let row3 = gen_list 10 |> List.map ((+) 20) |> bingo 
let rows = row1 @ row2 @ row3

let () = rows |> List.length |> Printf.printf "%d \n"


(* let () = gen_list 10 |> mutate |> List.length |> Printf.printf "%d \n" *)
(* let () = gen_list 10 |> bingo |> List.length |> Printf.printf "%d \n" *)
