let base_points = 1000.
let max_incorrect = 20.
let base_seconds = 60.
let additional_seconds = 30.

let rec helper lst1 lst2 acc =
  match lst1 with
  | [] -> acc
  | [ h1 ] -> (
      match lst2 with
      | [] -> acc
      | [ h2 ] -> if h1 == h2 then acc else acc + 1
      | h2 :: t2 -> if h1 == h2 then helper [] t2 acc else helper [] t2 (acc + 1)
      )
  | h1 :: t1 -> (
      match lst2 with
      | [] -> acc
      | [ h2 ] -> if h1 == h2 then acc else acc + 1
      | h2 :: t2 -> if h1 == h2 then helper t1 t2 acc else helper t1 t2 (acc + 1)
      )

let parse input state start_time end_time =
  let time_diff = end_time -. start_time in
  let input_char_list = List.init (String.length input) (String.get input) in
  let prompt_char_list =
    List.init
      (String.length (State.current_prompt state))
      (String.get (State.current_prompt state))
  in
  let acc =
    Int.abs (List.length prompt_char_list - List.length input_char_list)
  in
  let inc = helper input_char_list prompt_char_list acc in
  if float_of_int inc >= max_incorrect then 0
  else
    Float.to_int
      (base_points
      *. ((max_incorrect -. float_of_int inc) /. max_incorrect)
      /. (base_points *. ((max_incorrect -. float_of_int inc) /. max_incorrect))
         ** (time_diff
            /. (base_seconds
               +. additional_seconds
                  *. float_of_int (State.current_level state))))

(*let do_quick = raise (Failure "Unimplemented: Command.do_quick") let
  do_replace_a_e = raise (Failure "Unimplemented: Command.do_replace_a_e") let
  do_double = raise (Failure "Unimplemented: Command.do_double")*)
