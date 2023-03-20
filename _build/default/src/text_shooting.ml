type t = unit

exception NoPrompts
exception NoRules
exception UnknownRule of string

let from_json = raise (Failure "Unimplemented: Text_shooting.from_json")
let random_prompt = raise (Failure "Unimplemented: Text_shooting.random_prompt")
let random_rule = raise (Failure "Unimplemented: Text_shooting.random_rule")
let rule_desc = raise (Failure "Unimplemented: Text_shooting.rule_desc")
