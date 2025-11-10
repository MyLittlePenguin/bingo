open Permutations

let row1 = Per.gen_list 10 |> Per.bingo
let row2 = Per.gen_list 10 |> List.map (( + ) 5) |> Per.bingo
let row3 = Per.gen_list 10 |> List.map (( + ) 10) |> Per.bingo
let row4 = Per.gen_list 10 |> List.map (( + ) 15) |> Per.bingo
let row5 = Per.gen_list 10 |> List.map (( + ) 20) |> Per.bingo
let row6 = Per.gen_list 10 |> List.map (( + ) 25) |> Per.bingo
let row7 = Per.gen_list 10 |> List.map (( + ) 30) |> Per.bingo
let row8 = Per.gen_list 10 |> List.map (( + ) 35) |> Per.bingo
let row9 = Per.gen_list 10 |> List.map (( + ) 40) |> Per.bingo
let rows = row1 @ row2 @ row3 @ row4 @ row5 @ row6 @ row7 @ row8 @ row9

(* let row1 = Per.gen_list 10 |> Per.bingo *)
(* let row2 = Per.gen_list 10 |> List.map (( + ) 10) |> Per.bingo *)
(* let row3 = Per.gen_list 10 |> List.map (( + ) 20) |> Per.bingo *)
(* let rows = row1 @ row2 @ row3 *)
let output_file = Out_channel.open_text "bingos.csv"

let bingo_to_csv to_str bingo =
  bingo |> List.map (fun it -> "\"" ^ to_str it ^ "\"") |> String.concat ","

let gen_bingos limit rows =
  let pick_non_overlapping_row bingo rows =
    let rec aux acc rows =
      match rows with
      | [] -> (None, acc, [])
      | hd :: tl ->
          if Per.disjunct bingo hd then (Some hd, acc, tl)
          else aux (hd :: acc) tl
    in
    aux [] rows
  in
  let build_bingo rows =
    let rec aux row_count bingo rows_searched_acc rows =
      match row_count with
      | 0 -> (Some bingo, rows @ (rows_searched_acc |> List.flatten))
      | n -> (
          let row, rows_searched, rows_remaining =
            pick_non_overlapping_row bingo rows
          in
          match row with
          | None -> (None, rows @ (rows_searched_acc |> List.flatten))
          | Some row ->
              aux (n - 1) (bingo @ row)
                (rows_searched :: rows_searched_acc)
                rows_remaining)
    in
    aux 5 [] [] rows
  in
  let rec aux bingos rows =
    match rows with
    | [] -> bingos
    | _ when List.length rows < 5 -> bingos
    | _ when bingos >= limit -> bingos
    | _ -> (
        match build_bingo rows with
        | None, rows ->
            Printf.printf "no bingo found, %d rows left\n%!" (List.length rows);
            (* bingos *)
            aux bingos rows
        | Some bingo, rows ->
            (match bingos mod 10 with
            | 0 ->
                Printf.printf "bingo %d found, %d rows left\n%!" bingos
                  (List.length rows)
            | _ -> Printf.printf "bingo %d found\n%!" bingos);
            Printf.fprintf output_file "%s\n%!"
              (bingo_to_csv string_of_int bingo);
            aux (bingos + 1) rows)
  in
  aux 0 rows

let () =
  rows |> List.length |> Printf.printf "rows %d \n";
  let bingos = rows |> gen_bingos 2000 in
  (* bingos |> List.length |> Printf.printf "bingos %d \n"; *)
  bingos |> Printf.printf "bingos %d \n"
(* bingos |> List.map (bingo_to_csv string_of_int) |> List.iter (Printf.printf "%s\n") *)

(* let () = gen_list 10 |> mutate |> List.length |> Printf.printf "%d \n" *)
(* let () = gen_list 10 |> bingo |> List.length |> Printf.printf "%d \n" *)
