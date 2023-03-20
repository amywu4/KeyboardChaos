type t
(** The abstract type of values representing prompts and rules. *)

type rule = {
  name : string;
  description : string;
}

exception NoPrompts
exception NoRules
exception UnknownRule of string

val from_json : Yojson.Basic.t -> t
(** [from_json j] is the representation of prompts or rules that [j] represents.
    Requires: [j] is a valid JSON prompt representation. *)

val get_prompts : t -> string list
(** [get_prompts j] is a list of prompts in [t] *)

val random_prompt : t -> string
(** [random_prompt t] is a prompt randomly picked from the list of prompts
    [t.prompts]. Raises [NoPrompts] if [t] has no prompts.*)

val rule_name : rule -> string
(** [rule_name r] is the name of a rule [r] *)

val rule_description : rule -> string
(** [rule_description r] is the description of a rule [r] *)

val get_rules_names : t -> string list
(** [get_rules_names j] is a list of names of rules that [j] has *)

val get_rules_descriptions : t -> string list
(** [get_rules_descriptions r] is the description of rule [r] *)

val random_rule : t -> string
(** [random_rule t] is the name of a rule randomly picked from the list of rules
    [t.rules]. Raises [NoRules] if [t] has no rules.*)

(* val rule_desc : string -> t -> string (** [rule_desc n] provides the
   description of the rule with name [n] in [t]. Raises [UnknownRule n] if n is
   not the name of any rule in [t].*) *)
