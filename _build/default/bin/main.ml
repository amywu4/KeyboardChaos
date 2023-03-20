(** [main ()] prompts for the game to play, then starts it. *)
let main () =
  ANSITerminal.print_string [ ANSITerminal.red ]
    "\n\nWelcome to the Zenith Text Shooting Game engine.\n";
  print_endline "Would you like to start the game? [y/n]\n";
  print_string "> ";
  (* match read_line () with | exception End_of_file -> () | answer -> if
     lowercase_ascii answer = "y" then *)
  ()

(* Execute the game engine. *)
let () = main ()
