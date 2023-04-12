let base_points = 1000.
let max_incorrect = 20.
let base_seconds = 60.
let additional_seconds = 30.
let str_to_chars s = List.init (String.length s) (String.get s)
let chars_to_str cs = String.concat "" (List.map (String.make 1) cs)
let do_quick s = s

let do_no_spaces s =
  let chars = str_to_chars s in
  let no_spaces = List.filter (fun c -> c <> ' ') chars in
  chars_to_str no_spaces

let do_uppercase s = String.uppercase_ascii s
(*let do_replace_a_e = raise (Failure "Unimplemented: Command.do_replace_a_e")
  let do_double = raise (Failure "Unimplemented: Command.do_double")*)

(* let rec helper lst1 lst2 acc = match lst1 with | [] -> acc | [ h1 ] -> (
   match lst2 with | [] -> acc | [ h2 ] -> if h1 == h2 then acc else acc + 1 |
   h2 :: t2 -> if h1 == h2 then helper [] t2 acc else helper [] t2 (acc + 1) ) |
   h1 :: t1 -> ( match lst2 with | [] -> acc | [ h2 ] -> if h1 == h2 then acc
   else acc + 1 | h2 :: t2 -> if h1 == h2 then helper t1 t2 acc else helper t1
   t2 (acc + 1) )

   let rec lev lst1 lst2 acc = match lst1 with | [] -> List.length lst2 + acc |
   h1 :: t1 -> begin match lst2 with | [] -> List.length lst1 + acc | h2 :: t2
   -> if h1 = h2 then lev t1 t2 acc else min (min (lev t1 lst2 (acc + 1)) (lev
   lst1 t2 (acc + 1))) (lev t1 t2 (acc + 1)) end *)

let lev_mat lst1 lst2 =
  let length1 = List.length lst1 in
  let length2 = List.length lst2 in
  if length1 = 0 then length2
  else if length2 = 0 then length1
  else
    let matrix = Array.make_matrix (length1 + 1) (length2 + 1) 0 in
    for x = 0 to length1 do
      matrix.(x).(0) <- x
    done;
    for y = 0 to length2 do
      matrix.(0).(y) <- y
    done;
    for x = 1 to length1 do
      for y = 1 to length2 do
        if min x y = 0 then matrix.(x).(y) <- max x y
        else
          matrix.(x).(y) <-
            min
              (min (matrix.(x - 1).(y) + 1) (matrix.(x).(y - 1) + 1))
              (matrix.(x - 1).(y - 1)
              + if List.nth lst1 (x - 1) = List.nth lst2 (y - 1) then 0 else 1)
      done
    done;
    matrix.(length1).(length2)

let encode s =
  List.fold_right
    (fun (r : Text_shooting.rule) acc ->
      match r.name with
      | "quick" -> do_quick acc
      | "no spaces" -> do_no_spaces acc
      | "uppercase" -> do_uppercase acc
      | _ -> acc)
    (State.current_rules s) (State.current_prompt s)

(* let calc_points time inc state = Float.to_int (base_points *. ((max_incorrect
   -. float_of_int inc) /. max_incorrect) /. (base_points *. ((max_incorrect -.
   float_of_int inc) /. max_incorrect)) ** (time /. (base_seconds +.
   (additional_seconds *. float_of_int (State.current_level state)) ))) *)

let calc_points_2 time total inc state =
  let num = float_of_int total -. float_of_int inc in
  if num < 0. then 0
  else
    Float.to_int
      (num /. (time *. (0.9 ** float_of_int (State.current_level state)) /. 60.))

let parse input state start_time end_time =
  let time_diff = end_time -. start_time in
  let input_char_list = List.init (String.length input) (String.get input) in
  let correct_answer = encode state in
  let prompt_char_list =
    List.init (String.length correct_answer) (String.get correct_answer)
  in
  let inc = lev_mat input_char_list prompt_char_list in
  (calc_points_2 time_diff (List.length input_char_list) inc state, inc)
