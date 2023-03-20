type t
(** The abstract type of values representing prompts and rules. *)

type rule = {
  name : string;
  description : string;
}
(** The type of values representing a single rule. *)

type prompt = string
(** The type of values representing a single prompt. *)

exception NoPrompts
exception NoRules

val from_json : Yojson.Basic.t -> t
(** [from_json j] is the representation of prompts or rules that [j] represents.
    Requires: [j] is a valid JSON prompt representation. *)

val get_prompts : t -> prompt list
(** [get_prompts j] is a list of prompts in [t] *)

val random_prompt : t -> prompt
(** [random_prompt t] is a prompt randomly picked from the list of prompts
    [t.prompts]. Raises [NoPrompts] if [t] has no prompts.*)

val rule_name : rule -> string
(** [rule_name r] is the name of a rule [r] *)

val rule_description : rule -> string
(** [rule_description r] is the description of a rule [r] *)

(*val get_rules_names : t -> string list (** [get_rules_names j] is a list of
  names of rules that [j] has *)

  val get_rules_descriptions : t -> string list (** [get_rules_descriptions r]
  is the description of rule [r] *) *)

val get_rules : t -> rule list
(** [get_rules_names j] is a list of rules that [j] has *)

val random_rule : t -> rule
(** [random_rule t] is the rule randomly picked from the list of rules
    [t.rules]. Raises [NoRules] if [t] has no rules.*)
