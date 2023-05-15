open Zenith
open Command
open State
open Text_shooting

let congratulatory_msg () =
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \        \
     /\\                                                                \
     /\\                                                      \
     /\\                                                  ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \        \\/                              \
     /\\                                \\/                           \
     /\\                         \\/                              ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                                        \
     \\/                                                             \\/   ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                        \
     /\\                                                                 \
     /\\                                                      \
     /\\                                          ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                        \\/                               \
     /\\                                \\/                           \
     /\\                         \\/                         ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                                                         \
     \\/                                                             \
     \\/                                                    ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \     /\\                                                                \
     /\\                                                      \
     /\\                                                        ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \     \\/                              /\\                                \
     \\/                           /\\                         \
     \\/                             ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                                     \
     \\/                                                             \
     \\/                                                    ";
  ANSITerminal.print_string [ ANSITerminal.magenta ] "\n";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                    _______     _____      ____    ___    _______     \
     _______         ___        _____________     _______";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                   |       |   /      \\   |    \\  |   |  |       |  \
     |         \\      /   \\      |             |   /       \\";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                   |    ___|  |        |  |     \\ |   |  |    ___|  |    \
     |    |     /  |  \\     |____     ____|   \\   /   /";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                   |   |___   |    |   |  |      \\|   |  |    |  |  \
     |        /     /   _   \\         |   |         \\     \\";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                   |       |  |        |  |   |\\      |  |       |  |   \
     |\\   \\    /   / \\   \\        |   |        /   \\   \\";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                   |_______|   \\______/   |___| \\_____|  |_______|  \
     |___| \\___\\  /___/   \\___\\       |___|        \\_______/";
  ANSITerminal.print_string [ ANSITerminal.magenta ] "\n";
  ANSITerminal.print_string [ ANSITerminal.magenta ] "\n";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \    /\\                                                 \
     /\\                                                           \
     /\\                                                                            ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \    \\/                       /\\                        \
     \\/                              /\\                           \
     \\/                                   \
     /\\                                      ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                             \
     \\/                                                        \
     \\/                                                                \\/";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                /\\                                                 \
     /\\                                                           \
     /\\                                                ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                \\/                       /\\                        \
     \\/                              /\\                           \
     \\/                                   ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                                         \
     \\/                                                        \
     \\/                                                            ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \    /\\                                              \
     /\\                                                           \
     /\\                                                                            ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \    \\/                    /\\                        \
     \\/                              /\\                           \
     \\/                                   \
     /\\                                   ";
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "\n\
    \                          \
     \\/                                                        \
     \\/                                                                \\/";
  print_endline ""

let complete points state =
  congratulatory_msg ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    ("\n\nYou've completed the game! You got a grand total of "
    ^ string_of_int (current_points state + points)
    ^ " points. Congratulations!");
  print_endline ""

let print_level level =
  if level = 1 then begin
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \  ___        _______   ____      ____   _______    ___             \
       _____      ____    ___    _______         ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |   |      |       |  \\   \\    /   /  |       |  |   |           \
       /      \\   |    \\  |   |  |       |        ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |   |      |     __|   \\   \\  /   /   |     __|  |   |          \
       |        |  |     \\ |   |  |     __|        ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |   |____  |     __|    \\   \\/   /    |     __|  |   |____      |    \
       |   |  |      \\|   |  |     __|        ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |        | |       |     \\      /     |       |  |        |     \
       |        |  |   |\\      |  |       |        ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |________| |_______|      \\____/      |_______|  |________|      \
       \\______/   |___| \\_____|  |_______|        ";
    print_endline ""
  end
  else if level = 2 then begin
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \  ___        _______   ____      ____   _______    ___            \
       ___________   ____            ____    _____            ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |   |      |       |  \\   \\    /   /  |       |  |   |          \
       |           |  \\   \\    /\\    /   /   /      \\          ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |   |      |     __|   \\   \\  /   /   |     __|  |   |          \
       |____   ____|   \\   \\  /  \\  /   /   |        |         ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |   |____  |     __|    \\   \\/   /    |     __|  |   |____          \
       |   |        \\   \\/    \\/   /    |    |   |         ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |        | |       |     \\      /     |       |  |        |         \
       |   |         \\     /\\     /     |        |         ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |________| |_______|      \\____/      |_______|  |________|         \
       |___|          \\___/  \\___/       \\______/          ";
    print_endline ""
  end
  else if level = 3 then begin
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \  ___        _______   ____      ____   _______    ___             \
       ___________    ___    ___    _______      _______     _______      ";
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \ |   |      |       |  \\   \\    /   /  |       |  |   |           \
       |           |  |   |  |   |  |        \\   |       |   |       |      ";
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \ |   |      |     __|   \\   \\  /   /   |     __|  |   |           \
       |____   ____|  |   |__|   |  |    |    |  |     __|   |     __|     ";
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \ |   |____  |     __|    \\   \\/   /    |     __|  |   |____           \
       |   |      |    __    |  |        /   |     __|   |     __|     ";
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \ |        | |       |     \\      /     |       |  |        |          \
       |   |      |   |  |   |  |   |\\   \\   |       |   |       |     ";
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \ |________| |_______|      \\____/      |_______|  |________|          \
       |___|      |___|  |___|  |___| \\___\\  |_______|   |_______|     ";
    print_endline ""
  end
  else if level = 4 then begin
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \  ___        _______   ____      ____   _______    ___             \
       _________     _____      ___   ___    _______     ";
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \ |   |      |       |  \\   \\    /   /  |       |  |   |           \
       |         |   /      \\   |   | |   |  |        \\   ";
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \ |   |      |     __|   \\   \\  /   /   |     __|  |   |           \
       |    _____|  |        |  |   | |   |  |    |    |  ";
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \ |   |____  |     __|    \\   \\/   /    |     __|  |   |____       \
       |    __|     |    |   |  |   |_|   |  |        /   ";
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \ |        | |       |     \\      /     |       |  |        |      |   \
       |        |        |  |         |  |   |\\   \\   ";
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \ |________| |_______|      \\____/      |_______|  |________|      \
       |___|         \\______/   |_________|  |___| \\___\\  ";
    print_endline ""
  end
  else if level = 5 then begin
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \  ___        _______   ____      ____   _______    ___             \
       _________    ___   ____      ____   _______    ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |   |      |       |  \\   \\    /   /  |       |  |   |           \
       |         |  |   |  \\    \\  /    /  |       |   ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |   |      |     __|   \\   \\  /   /   |     __|  |   |           \
       |    _____|  |   |   \\    \\/    /   |     __|   ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |   |____  |     __|    \\   \\/   /    |     __|  |   |____       \
       |    __|     |   |    \\        /    |     __|   ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |        | |       |     \\      /     |       |  |        |      |   \
       |        |   |     \\      /     |       |   ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |________| |_______|      \\____/      |_______|  |________|      \
       |___|        |___|      \\____/      |_______|   ";
    print_endline ""
  end
  else if level = 6 then begin
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \  ___        _______   ____      ____   _______    ___              \
       _______     ___   ____    ____   ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |   |      |       |  \\   \\    /   /  |       |  |   |            \
       /       \\   |   |  \\   \\  /   /   ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |   |      |     __|   \\   \\  /   /   |     __|  |   |            \
       \\   /   /   |   |   \\   \\/   /    ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |   |____  |     __|    \\   \\/   /    |     __|  |   |____         \
       \\     \\    |   |    \\      /     ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |        | |       |     \\      /     |       |  |        |       /   \
       \\   \\   |   |   /   /\\   \\    ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |________| |_______|      \\____/      |_______|  |________|       \
       \\_______/   |___|  /___/  \\___\\   ";
    print_endline ""
  end
  else if level = 7 then begin
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \  ___        _______   ____      ____   _______    ___             \
       _______    _______   ____      ____   _______    ____    ___    ";
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \ |   |      |       |  \\   \\    /   /  |       |  |   |           \
       /       \\  |       |  \\   \\    /   /  |       |  |    \\  |   |   ";
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \ |   |      |     __|   \\   \\  /   /   |     __|  |   |           \
       \\   /   /  |     __|   \\   \\  /   /   |     __|  |     \\ |   |   ";
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \ |   |____  |     __|    \\   \\/   /    |     __|  |   |____        \
       \\     \\   |     __|    \\   \\/   /    |     __|  |      \\|   |   ";
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \ |        | |       |     \\      /     |       |  |        |      /   \
       \\   \\  |       |     \\      /     |       |  |   |\\      |   ";
    ANSITerminal.print_string [ ANSITerminal.cyan ]
      "\n\
      \ |________| |_______|      \\____/      |_______|  |________|      \
       \\_______/  |_______|      \\____/      |_______|  |___| \\_____|   ";
    print_endline ""
  end
  else if level = 8 then begin
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \  ___        _______   ____      ____   _______    ___             \
       _______    ___    _______    ___    ___    ___________   ";
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \ |   |      |       |  \\   \\    /   /  |       |  |   |           \
       |       |  |   |  |       |  |   |  |   |  |           |  ";
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \ |   |      |     __|   \\   \\  /   /   |     __|  |   |           \
       |     __|  |   |  |    ___|  |   |__|   |  |____   ____|  ";
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \ |   |____  |     __|    \\   \\/   /    |     __|  |   |____       \
       |     __|  |   |  |    |  |  |    __    |      |   |      ";
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \ |        | |       |     \\      /     |       |  |        |      \
       |       |  |   |  |       |  |   |  |   |      |   |      ";
    ANSITerminal.print_string [ ANSITerminal.blue ]
      "\n\
      \ |________| |_______|      \\____/      |_______|  |________|      \
       |_______|  |___|  |_______|  |___|  |___|      |___|      ";
    print_endline ""
  end
  else if level = 9 then begin
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \  ___        _______   ____      ____   _______    ___             \
       ____    ___    ___    ____    ___    _______    ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |   |      |       |  \\   \\    /   /  |       |  |   |           \
       |    \\  |   |  |   |  |    \\  |   |  |       |   ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |   |      |     __|   \\   \\  /   /   |     __|  |   |           \
       |     \\ |   |  |   |  |     \\ |   |  |     __|   ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |   |____  |     __|    \\   \\/   /    |     __|  |   |____       \
       |      \\|   |  |   |  |      \\|   |  |     __|   ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |        | |       |     \\      /     |       |  |        |      |   \
       |\\      |  |   |  |   |\\      |  |       |   ";
    ANSITerminal.print_string [ ANSITerminal.red ]
      "\n\
      \ |________| |_______|      \\____/      |_______|  |________|      \
       |___| \\_____|  |___|  |___| \\_____|  |_______|   ";
    print_endline ""
  end
  else begin
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \  ___        _______   ____      ____   _______    ___             \
       ___________    _______    ____    ___    ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |   |      |       |  \\   \\    /   /  |       |  |   |           \
       |           |  |       |  |    \\  |   |   ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |   |      |     __|   \\   \\  /   /   |     __|  |   |           \
       |____   ____|  |     __|  |     \\ |   |   ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |   |____  |     __|    \\   \\/   /    |     __|  |   |____           \
       |   |      |     __|  |      \\|   |   ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |        | |       |     \\      /     |       |  |        |          \
       |   |      |       |  |   |\\      |   ";
    ANSITerminal.print_string [ ANSITerminal.green ]
      "\n\
      \ |________| |_______|      \\____/      |_______|  |________|          \
       |___|      |_______|  |___| \\_____|   ";
    print_endline ""
  end

let rec print_rules levels game state =
  print_level (current_level state);
  ANSITerminal.print_string [ ANSITerminal.red ]
    ("\n\nWelcome to level "
    ^ string_of_int (current_level state)
    ^ "! You have "
    ^ string_of_int (current_points state)
    ^ " points. Your rules to follow (in order) are:\n");
  List.iteri
    (fun i r ->
      ANSITerminal.print_string [ ANSITerminal.red ]
        ("\n"
        ^ string_of_int (current_level state - i)
        ^ ". " ^ rule_description r))
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
  let cap = min 10 (num_rules game) in
  print_endline
    ("\nHow many levels would you like to play? You can have a maximum of "
   ^ string_of_int cap ^ " levels.");
  print_string "> ";
  match read_line () with
  | exception End_of_file -> ()
  | answer -> (
      match int_of_string answer with
      | exception Failure _ ->
          print_endline "\nNot a valid integer. Try again!";
          set_levels game state
      | levels ->
          if levels > cap then (
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
  Random.init (int_of_float (Unix.gettimeofday ()));
  try
    let game = from_json (Yojson.Basic.from_file f) in
    match init_state game with
    | exception NoPrompts ->
        print_endline "This game has no available prompts. Sorry!"
    | exception NoRules ->
        print_endline "This game has no available rules. Sorry!"
    | init -> set_levels game init
  with _ -> print_endline "Can't find the specified file. Sorry!"

let welcome_msg () =
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \               _____        _____   ________    ____         _______      \
     _____      ___      ___     ________     ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \               \\    \\      /    /  |        |  |    |       |       |   \
     /       \\   |   \\    /   |   |        |    ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                \\    \\    /    /   |      __|  |    |       |     __|  \
     |         |  |    \\  /    |   |      __|     ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                 \\    \\/\\/    /    |      __|  |    |____   |    |__   \
     |    |    |  |     \\/     |   |      __|      ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                  \\          /     |        |  |         |  |       |  \
     |         |  |    |\\/|    |   |        |     ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                   \\___/\\___/      |________|  |_________|  |_______|   \
     \\_______/   |____|  |____|   |________|    ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                                 _____________       \
     _____            ";
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                                |             |    \
     /       \\          ";
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                                |____     ____|   \
     |         |         ";
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                                     |   |        |    \
     |    |         ";
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                                     |   |        \
     |         |         ";
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                                     |___|         \
     \\_______/          ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                              ___   ____   ________   \
     ____    ____ ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                             |   | /   /  |        |  \
     \\   \\  /   / ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                             |   |/   /   |      __|   \
     \\   \\/   / ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                             |       \\    |      __|    \
     \\      /   ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                             |   |\\   \\   |        \
     |     |    |    ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                             |___| \\___\\  \
     |________|     |____|    ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                   ______        _____          \
     ___         _____       _____ ";
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                  |       \\    /       \\       /   \
     \\       |      \\    |     \\ ";
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                  |   |   |   |         |     /  |  \
     \\      |   |   |   |      \\ ";
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                  |      \\    |    |    |    /   _   \
     \\     |      /    |   |   |  ";
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                  |   |   |   |         |   /   / \\   \
     \\    |  |\\  \\    |      /  ";
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\
    \                                  |_______/    \\_______/   /___/   \
     \\___\\   |__| \\__\\   |_____/  ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                    _______     ___    ___        \
     ___          _____      _____     ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                   |       |   |   |  |   |      /   \
     \\       /       \\   /     \\   ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                   |    ___|   |   |__|   |     /  |  \
     \\     |         |  \\  /  /   ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                   |   |___    |    __    |    /   _   \
     \\    |    |    |   \\   \\   ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                   |       |   |   |  |   |   /   / \\   \
     \\   |         |  /  \\  \\  ";
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\
    \                                   |_______|   |___|  |___|  /___/   \
     \\___\\   \\_______/   \\_____/   ";
  print_newline ();
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "    \
     _________________________________________________________________________________________________________________________________";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |            |        |        |        |        |        |        \
     |        |        |        |        |        |        |        |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |____________|________|_____ __|__ _____|_____ __|_____ __|____ \
     ___|________|________|________|________|________|________|________|       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |        |        |        |        |        |        |        \
     |        |        |        |        |        |        |            \
     |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |        |        |        |        |        |        |        \
     |        |        |        |        |        |        |            \
     |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   \
     |________|________|________|________|________|________|________|________|________|________|________|________|________|____________|       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |            |        |        |        |        |        |        \
     |        |        |        |        |        |        |        |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |            |        |        |        |        |        |        \
     |        |        |        |        |        |        |        |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   \
     |____________|________|________|________|________|________|________|________|________|________|________|________|________|________|       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |               |        |        |        |        |        |        \
     |        |        |        |        |        |              |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |               |        |        |        |        |        |        \
     |        |        |        |        |        |              |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   \
     |_______________|________|________|________|________|________|________|________|________|________|________|________|______________|       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |                   |        |        |        |        |        \
     |        |        |        |        |        |                   |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |                   |        |        |        |        |        \
     |        |        |        |        |        |                   |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   \
     |___________________|________|________|________|________|________|________|________|________|________|________|___________________|       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |        |        |        |          \
     |                                            |          |        |        \
     |        |        |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   |        |        |        |          \
     |                                            |          |        |        \
     |        |        |       ";
  print_newline ();
  ANSITerminal.print_string [ ANSITerminal.magenta ]
    "   \
     |________|________|________|__________|____________________________________________|__________|________|________|________|________|       ";
  print_endline ""

let data_dir_prefix = "data" ^ Filename.dir_sep

(** [main ()] prompts for the game to play, then starts it. *)
let main () =
  welcome_msg ();
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
          "Please enter the name of the gamemode you want to play. There's \
           'standard' and 'math' modes available.\n";
        print_string "> ";
        match read_line () with
        | exception End_of_file -> ()
        | file_name -> play (data_dir_prefix ^ file_name ^ ".json"))
      else if String.lowercase_ascii answer = "n" then
        print_endline "Oh, alright. See ya!"
      else print_endline "Sorry, I'm not sure what you mean."

(* Execute the game engine. *)
let () = main ()
