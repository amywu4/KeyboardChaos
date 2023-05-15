open Zenith

module type TextShootingSig = sig
  type rule
  type prompt
  type t

  exception NoPrompts
  exception NoRules

  val from_json : Yojson.Basic.t -> t
  val get_prompts : t -> prompt list
  val random_prompt : prompt list -> prompt
  val rule_name : rule -> string
  val rule_description : rule -> string
  val get_rules : t -> rule list
  val num_rules : t -> int
  val random_rule : rule list -> rule
end

module TextShootingCheck : TextShootingSig = Text_shooting

module type CommandSig = sig
  val base_points : int
  val encode : State.t -> string
  val parse : string -> State.t -> float -> float -> int * int
end

module CommandCheck : CommandSig = Command

module type StateSig = sig
  type t

  exception NoRules

  val init_state : Text_shooting.t -> t
  val current_points : t -> int
  val current_level : t -> int
  val current_prompt : t -> Text_shooting.prompt
  val current_rules : t -> Text_shooting.rule list
  val available_rules : t -> Text_shooting.rule list
  val next_level : int -> Text_shooting.t -> t -> t
end

module StateCheck : StateSig = State

module type AuthorSig = sig
  val hours_worked : int
end

module AuthorCheck : AuthorSig = Author

let _ = if Author.hours_worked < 0 then exit 1
