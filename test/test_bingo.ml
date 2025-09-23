open Permutations

let () =
  assert (Per.gen_list 2 = [ 1; 2 ]);
  assert (Per.gen_list 0 = []);
  assert (Per.gen_list 5 = [ 1; 2; 3; 4; 5 ]);
  assert (Per.mutate [ 1; 2 ] = [ [ 2; 1 ]; [ 1; 2 ] ]);
  assert (Per.mutate [] = []);

  assert (Per.bingo [ 1; 2 ] = [ [ 2; 1 ]; [ 1; 2 ] ]);

  assert (Per.insert_at [ 1; 2; 3 ] 0 4 = [ 4; 1; 2; 3 ]);
  assert (Per.insert_at [ 1; 2; 3 ] 1 4 = [ 1; 4; 2; 3 ]);
  assert (Per.insert_at [ 1; 2; 3 ] 3 4 = [ 1; 2; 3; 4 ]);
  assert (Per.insert_at [] 2 4 = []);
  assert (Per.insert_at [] 1 4 = []);
  assert (Per.insert_at [] 0 4 = [ 4 ]);

  assert (Per.add_mutations [] 1 = [ [ 1 ] ]);
  assert (Per.add_mutations [ [ 1 ] ] 2 = [ [ 2; 1 ]; [ 1; 2 ] ]);
  (* assert ( *)
  (*   Per.add_mutations [ [ 2; 1 ]; [ 1; 2 ] ] 3 *)
  (*   = [ *)
  (*       [ 3; 2; 1 ]; *)
  (*       [ 2; 3; 1 ]; *)
  (*       [ 2; 1; 3 ]; *)
  (*       [ 3; 1; 2 ]; *)
  (*       [ 1; 3; 2 ]; *)
  (*       [ 1; 2; 3 ]; *)
  (*     ]) *)
