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

let current_points = raise (Failure "Unimplemented: State.current_points")
let current_level = raise (Failure "Unimplemented: State.current_level")
let current_prompt = raise (Failure "Unimplemented: State.current_prompt")
let current_rules = raise (Failure "Unimplemented: State.current_rules")
let next_level = raise (Failure "Unimplemented: State.next_level")
