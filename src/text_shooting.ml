open Yojson.Basic.Util

type prompt = string

type rule = {
  name : string;
  description : string;
}

type t = {
  prompts : prompt list;
  rules : rule list;
}

exception NoPrompts
exception NoRules

let rule json =
  {
    name = json |> member "name" |> to_string;
    description = json |> member "description" |> to_string;
  }

let from_json json =
  {
    prompts =
      json |> member "prompts" |> to_list |> List.map (fun x -> to_string x);
    rules = json |> member "rules" |> to_list |> List.map rule;
  }

let get_prompts ts = ts.prompts

let random_prompt prompts =
  if List.length prompts = 0 then raise NoPrompts
  else
    let random_int = Random.int (List.length prompts) in
    List.nth prompts random_int

let rule_name rule = rule.name
let rule_description rule = rule.description
let get_rules ts = ts.rules
let num_rules ts = List.length ts.rules

let rec random_rule rules =
  (*let list_diff = List.filter (fun x -> not (List.mem x (State.current_rules
    s))) ts.rules if List.length ts.rules = List.length (State.current_rules s)
    then raise NoRules else let random_int = Random.int (List.length ts.rules)
    in let rule = List.nth ts.rules random_int in if false then random_rule*)
  if List.length rules = 0 then raise NoRules
  else
    let random_int = Random.int (List.length rules) in
    List.nth rules random_int
