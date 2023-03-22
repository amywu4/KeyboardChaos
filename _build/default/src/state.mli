type t

exception NoRules

val init_state : Text_shooting.t -> t
(** [init_state a] is the initial state of the game when playing text shooting
    [a]. In that state the player is currently playing level one, they have 0
    points, and they currently have one randomly chosen prompt and the first
    rule in the list of rules to follow. *)

val current_points : t -> int
(** [current_points s] is the amount of points the player has currently
    accumulated in state [s].*)

val current_level : t -> int
(** [current_level s] is the level the player is currently playing on in state
    [s].*)

val current_prompt : t -> Text_shooting.prompt
(** [current_prompt s] is the prompt the player currently has to 'shoot' in game
    state [s].*)

val current_rules : t -> Text_shooting.rule list
(** [current_rules s] are the set of rules the player currently has to follow in
    game state [s].*)

val next_level : int -> Text_shooting.t -> t -> t
(** [next_level pts a s] modifies game state [s] by incrementing its points by
    pts, incrementing the level by 1, replacing the prompt with a new random
    prompt from game [a], and adding a new unique random rule from [a].*)
