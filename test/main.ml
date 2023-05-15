open OUnit2
open Zenith
open Text_shooting
open Command
open State

let data_dir_prefix = "testdata" ^ Filename.dir_sep

let get_adventure s =
  from_json (Yojson.Basic.from_file (data_dir_prefix ^ s ^ ".json"))

let dummy_a = get_adventure "dummy"
let advtests_a = get_adventure "advtests"

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

let rule_name_test (name : string) (r : Zenith.Text_shooting.rule)
    (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (rule_name r) ~printer:(fun x -> x)

let rule_description_test (name : string) (r : Zenith.Text_shooting.rule)
    (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (rule_description r) ~printer:(fun x -> x)

let num_rules_test (name : string) (ts : Zenith.Text_shooting.t)
    (expected_output : int) : test =
  name >:: fun _ -> assert_equal expected_output (num_rules ts)

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

let available_rules_length_test (name : string) (s : Zenith.State.t)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output (List.length (available_rules s))

let available_rules_helper (ts : Zenith.Text_shooting.t) (s : State.t) : bool =
  List.for_all (fun r -> List.mem r (get_rules ts)) (available_rules s)

let available_rules_test (name : string) (ts : Zenith.Text_shooting.t)
    (s : Zenith.State.t) (expected_output : bool) : test =
  name >:: fun _ -> assert_equal expected_output (available_rules_helper ts s)

let parse_points_test (name : string) (input : string) (state : State.t)
    (start_time : float) (end_time : float) (expected_output : int) : test =
  name >:: fun _ ->
  let result = parse input state start_time end_time in
  assert_equal expected_output (fst result) ~printer:string_of_int

let parse_mistakes_test (name : string) (input : string) (state : State.t)
    (start_time : float) (end_time : float) (expected_output : int) : test =
  name >:: fun _ ->
  let result = parse input state start_time end_time in
  assert_equal expected_output (snd result) ~printer:string_of_int

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
    rule_name_test "name of dummy rule is 'quick'"
      (random_rule (get_rules dummy_a))
      "quick";
    rule_description_test
      "description of dummy rule matches correct description"
      (random_rule (get_rules dummy_a))
      "Type the prompt as quickly as you can!";
  ]

let state_tests =
  [
    current_points_test "Points start at 0" (init_state dummy_a) 0;
    current_level_test "Level starts at 1" (init_state dummy_a) 1;
    current_prompt_test "Starting prompt is from adventure" dummy_a
      (init_state dummy_a) true;
    current_rules_length_test "Starting rule list has size 1"
      (init_state dummy_a) 1;
    current_rules_test "Starting rule is from adventure" dummy_a
      (init_state dummy_a) true;
    available_rules_length_test
      "In dummy, starting available rules list has size 0" (init_state dummy_a)
      0;
    available_rules_test "All available rules are from adventure" dummy_a
      (init_state dummy_a) true;
    available_rules_length_test
      "In advtests, starting available rules list has size 2"
      (init_state advtests_a) 2;
    available_rules_length_test
      "In advtests, by level 3 starting available rules list has size 0"
      (init_state advtests_a |> next_level 0 advtests_a
     |> next_level 0 advtests_a)
      0;
    current_points_test "Points are added"
      (init_state advtests_a |> next_level 100 advtests_a
     |> next_level 35 advtests_a)
      135;
    current_level_test "Levels are incremented"
      (init_state advtests_a |> next_level 100 advtests_a
     |> next_level 35 advtests_a)
      3;
    current_rules_length_test "# of rules at level 3 is 3"
      (init_state advtests_a |> next_level 100 advtests_a
     |> next_level 35 advtests_a)
      3;
  ]

let command_tests =
  (* points = (net^3 / (total^2 * time/60 * (0.9^levels))) *)
  [
    parse_mistakes_test
      "Exactly five characters are incorrect in the input string"
      "The wrong brown fox jumped over the lazy dog" (init_state dummy_a) 0. 10.
      5;
    parse_mistakes_test
      "Exactly five characters are incorrect in the input string: harder"
      "The quic brodn fox jumpred over thlazy dog" (init_state dummy_a) 0. 10. 5;
    parse_mistakes_test "All mistakes when input String is Empty" ""
      (init_state dummy_a) 0. 10. 44;
    parse_mistakes_test "Only one character is correct" "T" (init_state dummy_a)
      0. 10. 43;
    parse_mistakes_test "Completely Perfect"
      "The quick brown fox jumped over the lazy dog" (init_state dummy_a) 0. 0.
      0;
    parse_points_test
      "Points formula works correctly: 10 seconds, 5 mistakes, length of 44"
      "The wrong brown fox jumped over the lazy dog" (init_state dummy_a) 0. 10.
      204;
    parse_points_test "Points formula works correctly: 10 seconds, all mistakes"
      "" (init_state dummy_a) 0. 10. 0;
    parse_points_test
      "Points formula works correctly: 10 seconds, all but one mistake" "T"
      (init_state dummy_a) 0. 10. 0;
    parse_points_test "points cap for large points, or when time = 0"
      "The quick brown fox jumped over the lazy dog" (init_state dummy_a) 0. 0.
      base_points;
  ]

let tests =
  "zenith test suite"
  >::: List.flatten [ text_shooting_tests; state_tests; command_tests ]

let _ = run_test_tt_main tests
