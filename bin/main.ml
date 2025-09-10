open Permutations

let row1 = Per.gen_list 10 |> Per.bingo
let row2 = Per.gen_list 10 |> List.map ((+) 10) |> Per.bingo
let row3 = Per.gen_list 10 |> List.map ((+) 20) |> Per.bingo
let rows = row1 @ row2 @ row3

let () = rows |> List.length |> Printf.printf "%d \n"


(* let () = gen_list 10 |> mutate |> List.length |> Printf.printf "%d \n" *)
(* let () = gen_list 10 |> bingo |> List.length |> Printf.printf "%d \n" *)
