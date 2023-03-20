open Yojson.Basic.Util

type rule = {
  name : string;
  description : string;
}

type t = {
  prompts : string list;
  rules : rule list;
}

exception NoPrompts
exception NoRules
exception UnknownRule of string

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

let random_prompt ts =
  let random_int = Random.int (List.length ts.prompts) in
  List.nth ts.prompts random_int

(* let random_rule = raise (Failure "Unimplemented: Text_shooting.random_rule")
   let rule_desc = raise (Failure "Unimplemented: Text_shooting.rule_desc") *)
