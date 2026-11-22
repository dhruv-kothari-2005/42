:- use_module(library(plunit)).
:- consult('../code/42_q2.pl').

:- begin_tests(q2).

test(pdf_all_seven, true(Equations == [
    "4*2-5=3",
    "4*2=5+3",
    "4-2=5-3",
    "4/2=5-3",
    "4=2*(5-3)",
    "4=2+(5-3)",
    "4=2+5-3"
])) :-
    all_equations([4,2,5,3], Equations).

test(pdf_generator_backtracking, true(Count == 7)) :-
    findall(Equation, generate_equation([4,2,5,3], Equation), Answers),
    length(Answers, Count).

test(pdf_count, true(Count == 7)) :-
    count_equations([4,2,5,3], Count).

test(pdf_single_equation, true(Equations == ["2*4=8"])) :-
    all_equations([2,4,8], Equations).

test(pdf_canonical_form, [
    forall(member(Tree-Expected, [
        expr('*', expr('+', 4, 2), 3)-"(4+2)*3",
        expr('+', 4, expr('*', 2, 3))-"4+2*3",
        expr('*', expr('/', 8, 4), 2)-"8/4*2",
        expr('/', 8, expr('*', 4, 2))-"8/(4*2)",
        expr('-', expr('-', 1, 2), 3)-"1-2-3",
        expr('-', 1, expr('-', 2, 3))-"1-(2-3)",
        expr('+', 1, expr('+', 2, 3))-"1+(2+3)",
        expr('+', expr('+', 1, 2), 3)-"1+2+3"
    ])),
    true(Actual == Expected)
]) :-
    once(expression_string(Tree, Actual)).

test(generate_fails_without_equation, [
    forall(member(Numbers, [[2,3,4], [], [4]])),
    fail
]) :-
    generate_equation(Numbers, _).

test(empty_results_without_equation, [
    forall(member(Numbers, [[2,3,4], [], [4]])),
    true((Equations-Count) == ([]-0))
]) :-
    all_equations(Numbers, Equations),
    count_equations(Numbers, Count).

test(repeated_numbers, true(Equations == ["2*2=4", "2+2=4"])) :-
    all_equations([2,2,4], Equations).

test(zero_divisor_preserves_other_equations, true(Equations == [
    "1+0=1",
    "1-0=1",
    "1=0+1"
])) :-
    all_equations([1,0,1], Equations).

test(computed_zero_divisor, [fail]) :-
    expression_tree([6,2,2], expr('/', 6, expr('-', 2, 2)), _).

test(inexact_division_inside_product, [fail]) :-
    generate_equation([3,2,2,3], "3/2*2=3").

:- end_tests(q2).
