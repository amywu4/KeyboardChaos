type t = {
  points : int;
  level : int;
  prompt : string;
  rulesused : Text_shooting.rule list;
  rulesleft : Text_shooting.rule list;
}

exception NoRules

let init_state a =
  let used =
    match Text_shooting.get_rules a with
    | [] -> raise NoRules
    | h :: t -> [ h ]
  in
  let left =
    match Text_shooting.get_rules a with
    | [] -> raise NoRules
    | h :: t -> t
  in
  {
    points = 0;
    level = 1;
    prompt = Text_shooting.random_prompt (Text_shooting.get_prompts a);
    rulesused = used;
    rulesleft = left;
  }

let current_points s = s.points
let current_level s = s.level
let current_prompt s = s.prompt
let current_rules s = s.rulesused
let available_rules s = s.rulesleft

let rule_exists r s =
  match List.find_opt (fun x -> x = r) (current_rules s) with
  | None -> false
  | Some _ -> true

let next_level pts a s =
  let new_rule = Text_shooting.random_rule s.rulesleft in
  {
    points = s.points + pts;
    level = s.level + 1;
    prompt = Text_shooting.random_prompt (Text_shooting.get_prompts a);
    rulesused = new_rule :: s.rulesused;
    rulesleft = List.filter (fun x -> x <> new_rule) s.rulesleft;
  }
