
:- use_module(library(plunit)).

:- begin_tests(p1).

:- consult('../../code/42_q1.pl').

% A solution satisfying clues 1 to 8.
valid_solution([
    p('Alex', design, java, 'AI'),
    p('Ben', development, javascript, web),
    p('Carla', research, 'c++', data),
    p('Dana', testing, python, embedded)
]).

clue_1_counterexample([
    p('Alex', design, java, embedded),
    p('Ben', development, javascript, web),
    p('Carla', research, 'c++', data),
    p('Dana', testing, python, 'AI')
]).

clue_2_counterexample([
    p('Alex', research, 'c++', data),
    p('Ben', development, javascript, web),
    p('Carla', design, java, 'AI'),
    p('Dana', testing, python, embedded)
]).

clue_3_counterexample([
    p('Alex', research, python, data),
    p('Ben', development, 'c++', web),
    p('Carla', design, java, 'AI'),
    p('Dana', testing, javascript, embedded)
]).

clue_4_counterexample([
    p('Alex', design, java, 'AI'),
    p('Ben', development, javascript, embedded),
    p('Carla', research, 'c++', data),
    p('Dana', testing, python, web)
]).

clue_5_counterexample([
    p('Alex', research, java, data),
    p('Ben', development, 'c++', web),
    p('Carla', design, javascript, 'AI'),
    p('Dana', testing, python, embedded)
]).

clue_6_counterexample([
    p('Alex', design, java, 'AI'),
    p('Ben', development, javascript, web),
    p('Carla', testing, python, embedded),
    p('Dana', research, 'c++', data)
]).

clue_7_counterexample([
    p('Alex', testing, python, 'AI'),
    p('Ben', development, javascript, web),
    p('Carla', research, 'c++', data),
    p('Dana', design, java, embedded)
]).

clue_8_counterexample([
    p('Alex', research, javascript, embedded),
    p('Ben', development, 'c++', web),
    p('Carla', design, java, 'AI'),
    p('Dana', testing, python, data)
]).

% The solution retained by clue 9.
valid_solution_with_clue_9([
    p('Alex', design, java, embedded),
    p('Ben', development, javascript, web),
    p('Carla', testing, python, 'AI'),
    p('Dana', research, 'c++', data)
]).

test(clue_1_succeeds) :- valid_solution(S), once(clue(1, S)).
test(clue_2_succeeds) :- valid_solution(S), once(clue(2, S)).
test(clue_3_succeeds) :- valid_solution(S), once(clue(3, S)).
test(clue_4_succeeds) :- valid_solution(S), once(clue(4, S)).
test(clue_5_succeeds) :- valid_solution(S), once(clue(5, S)).
test(clue_6_succeeds) :- valid_solution(S), once(clue(6, S)).
test(clue_7_succeeds) :- valid_solution(S), once(clue(7, S)).
test(clue_8_succeeds) :- valid_solution(S), once(clue(8, S)).

test(clue_1_rejects_counterexample, [fail]) :- clue_1_counterexample(S), clue(1, S).
test(clue_2_rejects_counterexample, [fail]) :- clue_2_counterexample(S), clue(2, S).
test(clue_3_rejects_counterexample, [fail]) :- clue_3_counterexample(S), clue(3, S).
test(clue_4_rejects_counterexample, [fail]) :- clue_4_counterexample(S), clue(4, S).
test(clue_5_rejects_counterexample, [fail]) :- clue_5_counterexample(S), clue(5, S).
test(clue_6_rejects_counterexample, [fail]) :- clue_6_counterexample(S), clue(6, S).
test(clue_7_rejects_counterexample, [fail]) :- clue_7_counterexample(S), clue(7, S).
test(clue_8_rejects_counterexample, [fail]) :- clue_8_counterexample(S), clue(8, S).

test(clue_9_succeeds) :-
    valid_solution_with_clue_9(S),
    once(clue(9, S)).

test(clue_9_rejects_removed_solution, [fail]) :-
    valid_solution(S),
    clue(9, S).

% A solution can violate clue 2 when only clues 1, 3 and 5 are active.
test(partial_active_list_ignores_missing_clue) :-
    once((
        solve([1,3,5], S),
        \+ clue(2, S)
    )).

test(count_before_clue_9) :-
    count_solutions([1,2,3,4,5,6,7,8], 3).

test(count_after_clue_9) :-
    count_solutions([1,2,3,4,5,6,7,8,9], 1).

% main/0 may print any of the three original solutions.
test(main_output_format) :-
    with_output_to(string(Output), main),
    memberchk(Output, [
        "Alex = [design, java, AI]\nBen = [development, javascript, web]\nCarla = [research, c++, data]\nDana = [testing, python, embedded]\n",
        "Alex = [design, java, embedded]\nBen = [development, javascript, web]\nCarla = [testing, python, AI]\nDana = [research, c++, data]\n",
        "Alex = [testing, python, embedded]\nBen = [development, javascript, web]\nCarla = [design, java, AI]\nDana = [research, c++, data]\n"
    ]).

:- end_tests(p1).
run_p1_tests :-
    (   run_tests(p1)
    ->  writeln('PASS: All P1 tests passed.')
    ;   writeln('FAIL: One or more P1 tests failed.'),
        fail
    ).
