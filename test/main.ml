(* TEST PLAN:*)
(*>Our testing suite, most of all, was designed with the categorization of
  separate modules in mind. Since the hierarchy of modules goes Text Shooting ->
  State -> Command, our tests worked on the broadest module first (Text
  Shooting) before moving into the most dependent (Command).*)
(*>For most of our function tests, we used Black Box Testing to determine if our
  comment specifications matched the output of the function. This was easiest
  for Text Shooting and State, as it simply involved pulling data that already
  exists and can be simply manipulated. To avoid the indeterminacy caused by the
  use of Random in functions such as random_rule and random_prompt, we used
  specifically test-oriented JSON files only containing a single rule and prompt
  we know the contents of.*)
(*>Black Box Testing couldn't work with Command, as it involved many algorithms
  and helper functions hidden from the user. Among these are the points formula,
  the levenshtein distance algorithm, and helper functions for every rule
  currently available in the game. To test these, we had to use Glass Box
  Testing and look at our own understandings of what is supposed to be correct.
  We know what our points formula is in a mathematical sense, we know how many
  mistakes will be in a given string, and we know what each rule is supposed to
  look for, so Command's functions were tested with these prior understandings
  in mind.*)
(*>Even with Glass Box Testing, not everything can be properly tested. Because
  rules are pulled randomly and in random orders, it's impossible to
  comprehensively check every combination of rules in tandem to see if they
  function correctly. Additionally, we also can't test with OUnit whether a
  random function is truly random. In both of these cases, we had to test
  manually by just playing our game over and over again until we come across a
  combination or quirk that needs to be ironed out. Because we had a game plan
  going into our project to make sure our rules influence the products of other
  rules as little as possible, there are only very few combinations of rules
  that we believe could lead to special side effects, and we have tested all of
  these combinations.*)
(*>By understanding the contents of our code and specifications, and coming up
  with edge cases to test the correctness of, we believe our test suite
  demonstrates the correctness of our system as a whole.*)

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

let encode_test (name : string) (s : State.t) (expected_output : string) : test
    =
  name >:: fun _ ->
  assert_equal expected_output (encode s) ~printer:(fun x -> x)

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

let parse_tests =
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
    parse_points_test "Empty string at 0 time gives 0 points" ""
      (init_state dummy_a) 0. 0. 0;
    parse_points_test "Perfect string at 0 time still gives 0 points"
      "The quick brown fox jumped over the lazy dog" (init_state dummy_a) 0. 0.
      0;
    parse_points_test
      "Points formula works correctly: 10 seconds, all but one mistake" "T"
      (init_state dummy_a) 0. 10. 0;
    parse_points_test "Points cap for large points"
      "The quick brown fox jumped over the lazy dog" (init_state dummy_a) 0. 1.
      base_points;
  ]

let encode_tests =
  [
    encode_test "quick returns original string" (init_state dummy_a)
      "The quick brown fox jumped over the lazy dog";
    encode_test "no spaces removes spaces"
      (get_adventure "no_spaces_test" |> init_state)
      "Thequickbrownfoxjumpedoverthelazydog";
    parse_mistakes_test "no spaces: one mistake for each space kept"
      "The quick   brown fox jumped      over the  lazy   dog"
      (get_adventure "no_spaces_test" |> init_state)
      0. 10. 18;
    encode_test "uppercase makes all letters uppercase"
      (get_adventure "uppercase_test" |> init_state)
      "THE! QUICK BROWN! F0X JUMPED, OV3R THE LA2ZY... DOG";
    parse_mistakes_test
      "uppercase: one mistake for every LOWERCASE character kept"
      "The! quick brown! f0x jumped, ov3r the la2zy... dog"
      (get_adventure "uppercase_test" |> init_state)
      0. 10. 33;
    encode_test "replace a's with e's only turns a's into e's, keeping casing"
      (get_adventure "replace_a_e_test" |> init_state)
      "lezy   LEZY jumped JUMPED emerice EMERICE eMeRiCe EmErIcE";
    parse_mistakes_test "replace a e: one mistake for every a kept"
      "lazy   LAZY jumped JUMPED america AMERICA aMeRiCa AmErIcA"
      (get_adventure "replace_a_e_test" |> init_state)
      0. 10. 10;
    encode_test "replace i's with o's only turns i's into o's, keeping casing"
      (get_adventure "replace_i_o_test" |> init_state)
      "quock   QUOCK brown BROWN tool TOOL tOoL ToOl";
    parse_mistakes_test "replace i o: one mistake for every i kept"
      "quick   QUICK brown BROWN toil TOIL tOiL ToIl"
      (get_adventure "replace_i_o_test" |> init_state)
      0. 10. 6;
    encode_test "replace s's with z's only turns s's into z's, keeping casing"
      (get_adventure "replace_s_z_test" |> init_state)
      "jumpz   JUMPZ lazy LAZY zuzie ZUZIE zUzIe ZuZiE";
    parse_mistakes_test "replace s z: one mistake for every s kept"
      "jumps   JUMPS lazy LAZY suzie SUZIE sUzIe SuZiE"
      (get_adventure "replace_s_z_test" |> init_state)
      0. 10. 6;
    encode_test "double doubles every character, including spaces"
      (get_adventure "double_test" |> init_state)
      "TThhee    qquuiicckk  bbrroowwnn  ffooxx  jjuummppeedd  oovveerr  \
       tthhee  llaazzyy  ddoogg";
    parse_mistakes_test
      "double: mistakes for not doing rule = length of original string"
      "The  quick brown fox jumped over the lazy dog"
      (get_adventure "double_test" |> init_state)
      0. 10. 45;
    encode_test "reverse reverses the string"
      (get_adventure "reverse_test" |> init_state)
      "god yzal eht revo depmuj xof nworb kciuq    ehT";
    encode_test "remove punctuation removes all punctuation"
      (get_adventure "remove_punctuation_test" |> init_state)
      "A bee Its flyinghigh 420 ";
    parse_mistakes_test
      "remove punctuation: one mistake for every punctuation kept"
      "A, bee. It's; flying-high?!? 4/20: !@#$%^&*()"
      (get_adventure "remove_punctuation_test" |> init_state)
      0. 10. 20;
    encode_test
      "remove first character works properly on 1 and 0 character words"
      (get_adventure "remove_first_char_test" |> init_state)
      " uick rown ox umped ver o he azy og.    est-test ";
    parse_mistakes_test
      "remove first character: one mistake for every character not removed"
      "A quick brown fox jumped over to the lazy dog.   . test-test I"
      (get_adventure "remove_first_char_test" |> init_state)
      0. 10. 13;
    encode_test
      "remove last character works properly on 1 and 0 character words"
      (get_adventure "remove_last_char_test" |> init_state)
      " quic brow fo jumpe ove t th laz dog    test-tes ";
    parse_mistakes_test
      "remove last character: one mistake for every character not removed"
      "A quick brown fox jumped over to the lazy dog.   . test-test I"
      (get_adventure "remove_last_char_test" |> init_state)
      0. 10. 13;
    encode_test
      "reversing + remove first character = remove last character + reverse"
      (get_adventure "reverse_remove_first"
      |> init_state
      |> next_level 0 (get_adventure "reverse_remove_first"))
      (encode
         (get_adventure "remove_last_reverse"
         |> init_state
         |> next_level 0 (get_adventure "remove_last_reverse")));
    encode_test
      "reversing + remove last character = remove first character + reverse"
      (get_adventure "reverse_remove_last"
      |> init_state
      |> next_level 0 (get_adventure "reverse_remove_last"))
      (encode
         (get_adventure "remove_first_reverse"
         |> init_state
         |> next_level 0 (get_adventure "remove_first_reverse")));
    encode_test "plus to multiply only turns +'s into *'s"
      (get_adventure "plus_to_mult_test" |> init_state)
      "1 * 1 * 2 one * one * two";
    parse_mistakes_test "plus to multiply: one mistake for every + kept"
      "1 + 1 * 2 one + one * two"
      (get_adventure "plus_to_mult_test" |> init_state)
      0. 10. 2;
    encode_test "minus to div only turns -'s into /'s"
      (get_adventure "minus_to_div_test" |> init_state)
      "1 / 1 / 2 one / one / two";
    parse_mistakes_test "minus to div: one mistake for every - kept"
      "1 - 1 / 2 one - one / two"
      (get_adventure "minus_to_div_test" |> init_state)
      0. 10. 2;
    encode_test "add one works on positive numbers and select words"
      (get_adventure "add_one_test" |> init_state)
      "5 4 3 2 1 two three four five";
    encode_test "mult by two works on positive numbers and select words"
      (get_adventure "mult_two_test" |> init_state)
      "8 6 4 2 0 two four six eight";
    encode_test "add one then mult by two correctly applies the order"
      (get_adventure "add_then_mult"
      |> init_state
      |> next_level 0 (get_adventure "add_then_mult"))
      "10 8 6 4 2 four six eight ten";
    encode_test "mult by two then add one correctly applies the order"
      (get_adventure "mult_then_add"
      |> init_state
      |> next_level 0 (get_adventure "mult_then_add"))
      "9 7 5 3 1 three five seven nine";
  ]

let tests =
  "zenith test suite"
  >::: List.flatten
         [ text_shooting_tests; state_tests; parse_tests; encode_tests ]

let _ = run_test_tt_main tests
