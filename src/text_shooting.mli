(** Representation of static gamemode data.

    This module represents the data stored in gamemode files. It handles loading
    of that data from JSON as well as querying the data.*)

type rule = {
  name : string;
  description : string;
}
(** The type of values representing a single rule. *)

type prompt = string
(** The type of values representing a single prompt. *)

type t = {
  prompts : prompt list;
  rules : rule list;
}
(** The type of values representing the gamemode's prompts and rules. *)

exception NoPrompts
(** Raised when the gamemode has no prompts, and a call is made to receive a
    prompt.*)

exception NoRules
(** Raised when the gamemode has no rules, and a call is made to receive a rule.*)

val from_json : Yojson.Basic.t -> t
(** [from_json j] is the representation of prompts or rules that [j] represents.
    Requires: [j] is a valid JSON prompt representation. *)

val get_prompts : t -> prompt list
(** [get_prompts j] is a list of prompts in [t] *)

val random_prompt : prompt list -> prompt
(** [random_prompt t] is a prompt randomly picked from the list of prompts
    [t.prompts]. Raises [NoPrompts] if [t] has no prompts.*)

val rule_name : rule -> string
(** [rule_name r] is the name of a rule [r] *)

val rule_description : rule -> string
(** [rule_description r] is the description of a rule [r] *)

val get_rules : t -> rule list
(** [get_rules_names j] is a list of rules that [j] has *)

val num_rules : t -> int
(** [get_num_rules j] is the number of rules that [j] has *)

val random_rule : rule list -> rule
(** [random_rule t] is the rule randomly picked from the list of rules
    [t.rules]. Raises [NoRules] if [t] has no rules.*)
