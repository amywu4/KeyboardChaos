val base_points : float
val max_incorrect : float
val base_seconds : float
val additional_seconds : float

val parse : string -> State.t -> float -> float -> int
(** [parse input state start_time end_time] takes in user input, calculates the
    time it took for them to complete the prompt, and determines a score based
    on user accuracy. Requires: [input] is a valid string. [state] is a valid
    state [time] Unix time *)
