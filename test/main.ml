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

let text_shooting_tests =
  [
    random_prompt_test "random prompt of dummy is a valid prompt"
      (from_json dummy)
      (random_prompt (from_json dummy))
      true;
    random_prompt_test "random prompt of dummy is a valid prompt"
      (from_json dummy) "hello" false;
  ]

let tests = "zenith test suite" >::: List.flatten [ text_shooting_tests ]
let _ = run_test_tt_main tests
