type t = {
  points : int;
  level : int;
  prompt : string;
  rules : Text_shooting.rule list;
}

let init_state a =
  {
    points = 0;
    level = 1;
    prompt = Text_shooting.random_prompt a;
    rules = [ Text_shooting.random_rule a ];
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
    rules = Text_shooting.random_rule a :: s.rules;
  }
