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
  print_string "Hi!";
  {
    prompts =
      json |> member "prompts" |> to_list
      |> List.map (fun x ->
             print_string (to_string x);
             to_string x);
    rules = json |> member "rules" |> to_list |> List.map rule;
  }

let get_prompts ts = ts.prompts

let random_prompt ts =
  if List.length ts.prompts = 0 then raise NoPrompts
  else
    let random_int = Random.int (List.length ts.prompts) in
    List.nth ts.prompts random_int

let rule_name rule = rule.name
let rule_description rule = rule.description

(*let get_rules_names ts = ts.rules |> List.map (fun x -> x.name) |>
  List.sort_uniq compare

  let get_rules_descriptions ts = ts.rules |> List.map (fun x -> x.description)
  |> List.sort_uniq compare*)

let get_rules ts = ts.rules
let num_rules ts = List.length ts.rules

let random_rule ts =
  if List.length ts.rules = 0 then raise NoRules
  else
    let random_int = Random.int (List.length ts.rules) in
    List.nth ts.rules random_int

(* let rule_desc ts = raise (Failure "Unimplemented:
   Text_shooting.rule_desc") *)
