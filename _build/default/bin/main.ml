open Zenith
open Command
open State
open Text_shooting

let complete points state =
  ANSITerminal.print_string [ ANSITerminal.red ]
    ("\n\nYou've completed the game! You got a grand total of "
    ^ string_of_int (current_points state + points)
    ^ " points. Congratulations!");
  print_endline ""

let rec print_rules levels game state =
  ANSITerminal.print_string [ ANSITerminal.red ]
    ("\n\nWelcome to level "
    ^ string_of_int (current_level state)
    ^ "! You have "
    ^ string_of_int (current_points state)
    ^ " points. Your rules to follow are:\n");
  List.iter
    (fun r ->
      ANSITerminal.print_string [ ANSITerminal.red ] ("\n-" ^ rule_description r))
    (current_rules state);
  print_endline "\n\nPress enter to receive the prompt and start the timer.";
  print_string "> ";
  match read_line () with
  | exception End_of_file -> ()
  | _ -> print_prompt levels game state

and print_prompt levels game state =
  print_endline ("\n  " ^ current_prompt state);
  print_string "> ";
  let start_time = Unix.gettimeofday () in
  match read_line () with
  | exception End_of_file -> ()
  | answer -> (
      let end_time = Unix.gettimeofday () in
      let result = parse answer state start_time end_time in
      let points = fst result in
      let inc = snd result in
      print_endline
        ("\nYou got " ^ string_of_int points ^ " points in "
        ^ string_of_int (Float.to_int (end_time -. start_time))
        ^ " seconds! You made " ^ string_of_int inc ^ " mistakes.");
      print_endline ("The correct answer was '" ^ encode state ^ "'.");
      print_endline "Press enter to continue.";
      print_string "> ";
      match read_line () with
      | exception End_of_file -> ()
      | _ ->
          if current_level state = levels then complete points state
          else print_rules levels game (next_level points game state))

let rec set_levels game state =
  print_endline
    ("\nHow many levels would you like to play? You can have a maximum of "
    ^ string_of_int (num_rules game)
    ^ " levels.");
  print_string "> ";
  match read_line () with
  | exception End_of_file -> ()
  | answer -> (
      match int_of_string answer with
      | exception Failure _ ->
          print_endline "\nNot a valid integer. Try again!";
          set_levels game state
      | levels ->
          if levels > num_rules game then (
            print_endline "\nLevel count set too high. Try again!";
            set_levels game state)
          else if levels < 1 then (
            print_endline
              "\n\
               Level count set too low, you must have at least 1 level. Try \
               again!";
            set_levels game state)
          else print_rules levels game state)

let play f =
  try
    let game = from_json (Yojson.Basic.from_file f) in
    match init_state game with
    | exception NoPrompts ->
        print_endline "This game has no available prompts. Sorry!"
    | exception NoRules ->
        print_endline "This game has no available rules. Sorry!"
    | init -> set_levels game init
  with _ -> print_endline "Can't find the specified file. Sorry!"

let data_dir_prefix = "data" ^ Filename.dir_sep

(** [main ()] prompts for the game to play, then starts it. *)
let main () =
  (* print_string "\n ___ ___ __________ "; print_string "\n | | / / | _____| ";
     print_string "\n | |/ / | |___ "; print_string "\n | \\ | ___| ";
     print_string "\n | |\\ \\ | |_____ "; print_string "\n |__| \\___\\
     |________|"; *)
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \              _____        _____   ________     ____          \
     _______       _____       ___      ___     ________     ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \              \\    \\      /    /  |    ____|   |    |        |       \
     |    /       \\    |   \\    /   |   |    ____|    ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \               \\    \\    /    /   |   |__      |    |        |    \
     ___|   |         |   |    \\  /    |   |   |__       ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                \\    \\/\\/    /    |    __|     |    |____    |   \
     |___    |    |    |   |     \\/     |   |    __|      ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                 \\          /     |   |____    |         |   |       |   \
     |         |   |    |\\/|    |   |   |____     ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                  \\___/\\___/      |________|   |_________|   \
     |_______|    \\_______/    |____|  |____|   |________|    ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                                 _____________       \
     _____            ";
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                                |             |    \
     /       \\          ";
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                                |____     ____|   \
     |         |         ";
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                                     |   |        |    \
     |    |         ";
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                                     |   |        \
     |         |         ";
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                                     |___|         \
     \\_______/          ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                              ___   ___     ________    \
     ___    ___ ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                              |  | /  /    |    ____|   \
     \\  \\  /  / ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                              |  |/  /     |   |__       \
     \\  \\/  / ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                              |      \\     |    \
     __|       \\    /   ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                              |  |\\   \\    |   \
     |____       |  |    ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                              |__| \\___\\   \
     |________|      |__|    ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                   ______        _____          \
     ___         _____       _____ ";
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                  |       \\    /       \\       /   \
     \\       |      \\    |     \\ ";
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                  |   |   |   |         |     /  |  \
     \\      |   |   |   |      \\ ";
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                  |      \\    |    |    |    /   _   \
     \\     |      /    |   |   |  ";
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                  |   |   |   |         |   /   / \\   \
     \\    |  |\\  \\    |      /  ";
  ANSITerminal.print_string [ ANSITerminal.black ]
    "\n\
    \                                  |_______/    \\_______/   /___/   \
     \\___\\   |__| \\__\\   |_____/  ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                    _______     ___    ___        \
     ___          _____      _____     ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                   |       |   |   |  |   |      /   \
     \\       /       \\   /     \\   ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                   |    ___|   |   |__|   |     /  |  \
     \\     |         |  \\  /  /   ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                   |   |___    |    __    |    /   _   \
     \\    |    |    |   \\   \\   ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                   |       |   |   |  |   |   /   / \\   \
     \\   |         |  /  \\  \\  ";
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\
    \                                   |_______|   |___|  |___|  /___/   \
     \\___\\   \\_______/   \\_____/   ";
  print_newline ();
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "    \
     _________________________________________________________________________________________________________________________________";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |            |        |        |        |        |        |        \
     |        |        |        |        |        |        |        |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |____________|________|_____ __|__ _____|_____ __|_____ __|____ \
     ___|________|________|________|________|________|________|________|       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |        |        |        |        |        |        |        \
     |        |        |        |        |        |        |            \
     |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |        |        |        |        |        |        |        \
     |        |        |        |        |        |        |            \
     |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   \
     |________|________|________|________|________|________|________|________|________|________|________|________|________|____________|       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |            |        |        |        |        |        |        \
     |        |        |        |        |        |        |        |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |            |        |        |        |        |        |        \
     |        |        |        |        |        |        |        |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   \
     |____________|________|________|________|________|________|________|________|________|________|________|________|________|________|       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |               |        |        |        |        |        |        \
     |        |        |        |        |        |              |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |               |        |        |        |        |        |        \
     |        |        |        |        |        |              |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   \
     |_______________|________|________|________|________|________|________|________|________|________|________|________|______________|       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |                   |        |        |        |        |        \
     |        |        |        |        |        |                   |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |                   |        |        |        |        |        \
     |        |        |        |        |        |                   |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   \
     |___________________|________|________|________|________|________|________|________|________|________|________|___________________|       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |        |        |        |          \
     |                                            |          |        |        \
     |        |        |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   |        |        |        |          \
     |                                            |          |        |        \
     |        |        |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.black ]
    "   \
     |________|________|________|__________|____________________________________________|__________|________|________|________|________|       ";
  print_newline ();

  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\nWelcome to Keyboard Chaos!\n";
  print_newline ();
  print_endline "Would you like to start the game? [y/n]\n";
  print_string "> ";
  match read_line () with
  | exception End_of_file -> ()
  | answer ->
      if String.lowercase_ascii answer = "y" then (
        print_endline
          "Please enter the name of the game file you want to load.\n";
        print_string "> ";
        match read_line () with
        | exception End_of_file -> ()
        | file_name -> play (data_dir_prefix ^ file_name ^ ".json"))
      else if String.lowercase_ascii answer = "n" then
        print_endline "Oh, alright. See ya!"
      else print_endline "Sorry, I'm not sure what you mean."

(* Execute the game engine. *)
let () = main ()
