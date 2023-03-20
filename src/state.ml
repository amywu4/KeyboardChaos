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
let current_prompt s = raise (Failure "Unimplemented: State.current_prompt")
let current_rules s = raise (Failure "Unimplemented: State.current_rules")
let next_level pts a s = raise (Failure "Unimplemented: State.next_level")
