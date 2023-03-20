open OUnit2
open Zenith
open Text_shooting
open Command
open State

let data_dir_prefix = "data" ^ Filename.dir_sep
let dummy = Yojson.Basic.from_file (data_dir_prefix ^ "dummy.json")

let random_prompt_helper (ts : Zenith.Text_shooting.t) (rand : string) : bool =
  List.mem rand (get_prompts ts)

let random_prompt_test (name : string) (ts : Zenith.Text_shooting.t)
    (rand : string) (expected_output : bool) : test =
  name >:: fun _ -> assert_equal expected_output (random_prompt_helper ts rand)

let random_rule_helper (ts : Zenith.Text_shooting.t) (rand : rule) : bool =
  List.mem rand (get_rules ts)

let random_rule_test (name : string) (ts : Zenith.Text_shooting.t)
    (rand : Zenith.Text_shooting.rule) (expected_output : bool) : test =
  name >:: fun _ -> assert_equal expected_output (random_rule_helper ts rand)

let text_shooting_tests =
  [
    random_prompt_test "random prompt of dummy is a valid prompt in dummy"
      (from_json dummy)
      (random_prompt (from_json dummy))
      true;
    random_prompt_test "'hello' is not a valid prompt in dummy"
      (from_json dummy) "hello" false;
    random_rule_test "random rule of dummy is a valid rule in dummy"
      (from_json dummy)
      (random_rule (from_json dummy))
      true;
    random_rule_test "'hello' is not a valid rule in dummy" (from_json dummy)
      { name = "hello"; description = "placeholder" }
      false;
  ]

let tests = "zenith test suite" >::: List.flatten [ text_shooting_tests ]
let _ = run_test_tt_main tests
