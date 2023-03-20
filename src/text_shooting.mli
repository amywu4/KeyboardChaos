type t
(** The abstract type of values representing prompts and rules. *)

exception NoItems

val prompts : t
(** [prompts] stores a representation of prompt.json.*)

val rules : t
(** [rules] stores a representation of prompt.json.*)

val from_json : Yojson.Basic.t -> t
(** [from_json j] is the representation of prompts or rules that [j] represents.
    Requires: [j] is a valid JSON prompt representation. *)

val random_item : t -> string
(** [random_item l] is an element randomly picked from the list of prompts/rules
    [l]. Raises [NoItems] if [l] has no items.*)
