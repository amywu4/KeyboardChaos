type t = {
  points : int;
  level : int;
  prompt : string;
  rules : Text_shooting.rule list;
}

exception NoRules

let init_state a =
  {
    points = 0;
    level = 1;
    prompt = Text_shooting.random_prompt a;
    rules =
      (try [ List.nth (Text_shooting.get_rules a) 0 ]
       with Failure n -> raise NoRules);
  }

let current_points s = s.points
let current_level s = s.level
let current_prompt s = s.prompt
let current_rules s = s.rules

let next_level pts a s =
  {
    points = s.points + pts;
    level = s.level + 1;
    prompt = Text_shooting.random_prompt a;
    rules = s.rules;
  }
