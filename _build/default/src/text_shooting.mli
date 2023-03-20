type t
(** The abstract type of values representing prompts and rules. *)

exception NoPrompts
exception NoRules
exception UnknownRule of string

val from_json : Yojson.Basic.t -> t
(** [from_json j] is the representation of prompts or rules that [j] represents.
    Requires: [j] is a valid JSON prompt representation. *)

val get_prompts : t -> string list
(** [get_prompts j] is a list of strings that represent prompts *)

val random_prompt : t -> string
(** [random_prompt t] is a prompt randomly picked from the list of prompts
    [t.prompts]. Raises [NoPrompts] if [t] has no prompts.*)

(* val random_rule : t -> string (** [random_rule t] is the name of a rule
   randomly picked from the list of rules [t.rules]. Raises [NoRules] if [t] has
   no rules.*)

   val rule_desc : string -> t -> string (** [rule_desc n] provides the
   description of the rule with name [n] in [t]. Raises [UnknownRule n] if n is
   not the name of any rule in [t].*) *)
