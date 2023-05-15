(** Representation of dynamic game state.

    This module represents the state of a game as it is being played, including
    the gamer's current points, level, prompt, rules, and available rules for
    future levels. *)

type t
(** The abstract type of values representing the game's state. Each state
    contains information for the current points, level, prompt, current rules,
    and available rules for future levels. Requires: there is no overlap between
    the current rules and available rules.*)

exception NoRules
(** Raised when the game state has run out of available rules to give for the
    current level.*)

val init_state : Text_shooting.t -> t
(** [init_state a] is the initial state of the game when playing gamemode [a].
    In that state the player is currently playing level one, they have 0 points,
    and they currently have one randomly chosen prompt and the first rule in the
    list of rules to follow, with the rest of rules put into the state's list of
    available rules.*)

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

val available_rules : t -> Text_shooting.rule list
(** [available_rules s] are the set of rules the current game may provide in
    future levels, as dictated by game state [s].*)

val next_level : int -> Text_shooting.t -> t -> t
(** [next_level pts a s] modifies game state [s] by incrementing its points by
    pts, incrementing the level by 1, replacing the prompt with a new random
    prompt from gamemode [a], and adding a new unique random rule based on state
    [s]'s list of available rules.*)
