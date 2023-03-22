val base_points : float
val max_incorrect : float
val base_seconds : float
val additional_seconds : float

val encode : State.t -> string
(** [encode s] determines what the correct string of text to type would have
    been for the current level of State [s] by encoding the current prompt with
    the current rules in order. Requires: [s] is a valid state.*)

val parse : string -> State.t -> float -> float -> int
(** [parse input state start_time end_time] takes in user input, calculates the
    time it took for them to complete the prompt, and determines a score based
    on user accuracy. Requires: [input] is a valid string. [state] is a valid
    state. [end_time] is greater than [start_time]. *)
