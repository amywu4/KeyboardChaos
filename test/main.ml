open OUnit2
open Zenith
open Text_shooting
open Command
open State

let data_dir_prefix = "data" ^ Filename.dir_sep
let dummy = Yojson.Basic.from_file (data_dir_prefix ^ "dummy.json")
let dummy_a = from_json dummy
let gameone = Yojson.Basic.from_file (data_dir_prefix ^ "gameone.json")
let gameone_a = from_json gameone

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

let current_points_test (name : string) (s : Zenith.State.t)
    (expected_output : int) : test =
  name >:: fun _ -> assert_equal expected_output (current_points s)

let current_level_test (name : string) (s : Zenith.State.t)
    (expected_output : int) : test =
  name >:: fun _ -> assert_equal expected_output (current_level s)

let current_prompt_helper (ts : Zenith.Text_shooting.t) (s : State.t) : bool =
  List.mem (current_prompt s) (get_prompts ts)

let current_prompt_test (name : string) (ts : Zenith.Text_shooting.t)
    (s : Zenith.State.t) (expected_output : bool) : test =
  name >:: fun _ -> assert_equal expected_output (current_prompt_helper ts s)

let current_rules_length_test (name : string) (s : Zenith.State.t)
    (expected_output : int) : test =
  name >:: fun _ -> assert_equal expected_output (List.length (current_rules s))

let current_rules_helper (ts : Zenith.Text_shooting.t) (s : State.t) : bool =
  List.for_all (fun r -> List.mem r (get_rules ts)) (current_rules s)

let current_rules_test (name : string) (ts : Zenith.Text_shooting.t)
    (s : Zenith.State.t) (expected_output : bool) : test =
  name >:: fun _ -> assert_equal expected_output (current_rules_helper ts s)

let parse_test (name : string) (input : string) (state : State.t)
    (start_time : float) (end_time : float) (expected_output : int * int) : test
    =
  name >:: fun _ ->
  let result = parse input state start_time end_time in
  assert_equal (fst expected_output) (fst result);
  assert_equal (snd expected_output) (snd result) ~printer:string_of_int

let text_shooting_tests =
  [
    random_prompt_test "random prompt of dummy is a valid prompt in dummy"
      dummy_a
      (random_prompt (get_prompts dummy_a))
      true;
    random_prompt_test "'hello' is not a valid prompt in dummy" dummy_a "hello"
      false;
    random_rule_test "random rule of dummy is a valid rule in dummy" dummy_a
      (random_rule (get_rules dummy_a))
      true;
    random_rule_test "'hello' is not a valid rule in dummy" dummy_a
      { name = "hello"; description = "placeholder" }
      false;
  ]

let state_tests =
  [
    current_points_test "Points start at 0" (init_state dummy_a) 0;
    current_level_test "Level starts at 1" (init_state dummy_a) 1;
    current_prompt_test "Starting prompt is from adventure" dummy_a
      (init_state dummy_a) true;
    current_rules_length_test "Starting rule list is 1" (init_state dummy_a) 1;
    current_rules_test "Starting rule is from adventure" dummy_a
      (init_state dummy_a) true;
    current_points_test "Points are added"
      (init_state dummy_a |> next_level 100 dummy_a |> next_level 35 dummy_a)
      135;
    current_level_test "Levels are incremented"
      (init_state dummy_a |> next_level 100 dummy_a |> next_level 35 dummy_a)
      3;
    current_rules_length_test "# of rules at level 3 is 3"
      (init_state gameone_a |> next_level 100 gameone_a
     |> next_level 35 gameone_a)
      3;
  ]

let command_tests =
  [
    parse_test "Exactly five characters are incorrect in the input string"
      "The wrong brown fox jumped over the lazy dog" (init_state dummy_a) 0. 10.
      (234, 5);
    parse_test
      "Exactly five characters are incorrect in the input string: harder"
      "The quic brodn fox jumpred over thlazy dog" (init_state dummy_a) 0. 10.
      (234, 5);
    parse_test "Input String is Empty" "" (init_state dummy_a) 0. 10. (0, 44);
    parse_test "Only one character is correct" "T" (init_state dummy_a) 0. 10.
      (0, 43)
    (* parse_test "Completely Perfect like Danish :)" "The quick brown fox
       jumped over the lazy dog" (init_state (dummy_a)) 0. 0. 1000; *);
  ]

let tests =
  "zenith test suite"
  >::: List.flatten [ text_shooting_tests; state_tests; command_tests ]

let _ = run_test_tt_main tests
