(** Parsing of player commands. *)

val base_points : int
(** [base_points] is the maximum cap to points a player can earn in a single
    level.*)

val encode : State.t -> string
(** [encode s] determines what the correct string of text to type would have
    been for the current level of State [s] by encoding the current prompt with
    the current rules in order. Requires: [s] is a valid state.*)

val parse : string -> State.t -> float -> float -> int * int
(** [parse input state start_time end_time] takes in user input, calculates the
    time it took for them to complete the prompt, and returns both a score based
    on user accuracy as well as the number of incorrect characters total.
    Requires: [input] is a valid string. [state] is a valid state. [end_time] is
    greater than [start_time]. *)
