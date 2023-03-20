type t

val init_state : Text_shooting.t -> t
(** [init_state a] is the initial state of the game when playing text shooting
    [a]. In that state the player is currently playing level one, and they
    currently have a set of rules to follow. *)

val current_points : t -> int
(** [current_points a] is the amount of points the player has currently
    accumulated in the game when playing text shooting game [a].*)

val current_level : t -> int
(** [current_level a] is the level the player is currently playing in the game
    when playing text shooting game [a].*)

val current_prompt : t -> Text_shooting.t
(** [current_prompt a] is the prompt the player currently has to 'shoot' when
    playing text shooting game [a].*)

val current_rules : t -> Text_shooting.t
(** [current_rules a] are the set of rules the player currently has to follow
    when playing text shooting game [a].*)

val next_level : t -> t
(** [next_level pt prompt state] are the set of rules the player currently has
    to follow when playing text shooting game [a].*)
