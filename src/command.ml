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

let switch_a_e c =
  if Char.lowercase_ascii c = 'a' then Char.chr (Char.code c + 4) else c

let do_replace_a_e s =
  let chars = str_to_chars s in
  let replace_a_e = List.map (fun c -> switch_a_e c) chars in
  chars_to_str replace_a_e

let switch_i_o c =
  if Char.lowercase_ascii c = 'i' then Char.chr (Char.code c + 6) else c

let do_replace_i_o s =
  let chars = str_to_chars s in
  let replace_i_o = List.map (fun c -> switch_i_o c) chars in
  chars_to_str replace_i_o

let switch_s_z c =
  if Char.lowercase_ascii c = 's' then Char.chr (Char.code c + 7) else c

let do_replace_s_z s =
  let chars = str_to_chars s in
  let replace_s_z = List.map (fun c -> switch_s_z c) chars in
  chars_to_str replace_s_z

let do_double s =
  let lst = str_to_chars s in
  let rec do_double_helper lst =
    match lst with
    | [] -> []
    | hd :: tl -> hd :: hd :: do_double_helper tl
  in
  chars_to_str (do_double_helper lst)

let do_reverse str =
  let len = String.length str in
  let rec reverse_helper index acc =
    if index < 0 then acc
    else reverse_helper (index - 1) (acc ^ String.make 1 str.[index])
  in
  reverse_helper (len - 1) ""

let remove_punctuation str =
  let punctuation =
    [
      ',';
      '.';
      '?';
      '/';
      ':';
      ';';
      '!';
      '@';
      '#';
      '$';
      '%';
      '^';
      '&';
      '*';
      '(';
      ')';
      '~';
      '`';
      '-';
      '_';
      '+';
      '=';
      '\'';
      '\"';
    ]
  in
  let rec remove_helper index acc =
    if index >= String.length str then acc
    else if List.mem str.[index] punctuation then remove_helper (index + 1) acc
    else remove_helper (index + 1) (acc ^ String.make 1 str.[index])
  in
  remove_helper 0 ""

let remove_first_letter str =
  let words = String.split_on_char ' ' str in
  let removed_words =
    List.map
      (fun word ->
        if String.length word = 1 then ""
        else String.sub word 1 (String.length word - 1))
      words
  in
  String.concat " " removed_words

let remove_last_letter (s : string) : string =
  let words = String.split_on_char ' ' s in
  let removed_words =
    List.map (fun word -> String.sub word 0 (String.length word - 1)) words
  in
  String.concat " " removed_words

let word_add =
  [
    ("one", "two");
    ("two", "three");
    ("three", "four");
    ("four", "five");
    ("six", "twelve");
    ("eight", "sixteen");
  ]

let word_mult =
  [
    ("one", "two");
    ("two", "four");
    ("three", "six");
    ("four", "eight");
    ("five", "ten");
  ]

let do_add_one (s : string) : string =
  let words = String.split_on_char ' ' s in
  let do_add_one_helper w =
    if String.length w = 1 then
      try string_of_int (int_of_string w + 1) with Failure _ -> w
    else snd (List.find (fun v -> fst v = w) word_add)
  in
  let new_words = List.map do_add_one_helper words in
  String.concat " " new_words

let do_mult_two (s : string) : string =
  let words = String.split_on_char ' ' s in
  let do_mult_two_helper w =
    if String.length w = 1 then
      try string_of_int (int_of_string w * 2) with Failure _ -> w
    else snd (List.find (fun v -> fst v = w) word_mult)
  in
  let new_words = List.map do_mult_two_helper words in
  String.concat " " new_words

let switch_plus_mult c = if c = '+' then '*' else c

let do_replace_plus_mult s =
  let chars = str_to_chars s in
  let replace_plus_mult = List.map (fun c -> switch_plus_mult c) chars in
  chars_to_str replace_plus_mult

let switch_minus_div w = if w = "-" then "/" else w

let do_replace_minus_div s =
  let words = String.split_on_char ' ' s in
  let replace_minus_div = List.map (fun w -> switch_minus_div w) words in
  String.concat " " replace_minus_div

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

let string_of_chars chars =
  let buf = Buffer.create 16 in
  List.iter (Buffer.add_char buf) chars;
  Buffer.contents buf

let encode s =
  List.fold_right
    (fun (r : Text_shooting.rule) acc ->
      match r.name with
      | "quick" -> do_quick acc
      | "no spaces" -> do_no_spaces acc
      | "uppercase" -> do_uppercase acc
      | "replace a's with e's" -> do_replace_a_e acc
      | "replace i's with o's" -> do_replace_i_o acc
      | "replace s's with z's" -> do_replace_s_z acc
      | "double" -> do_double acc
      | "reverse" -> do_reverse acc
      | "remove punctuation" -> remove_punctuation acc
      | "remove first letter" -> remove_first_letter acc
      | "remove last letter" -> remove_last_letter acc
      | "add one" -> do_add_one acc
      | "mult by two" -> do_mult_two acc
      | "plus to multiply" -> do_replace_plus_mult acc
      | "minus to divide" -> do_replace_minus_div acc
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
