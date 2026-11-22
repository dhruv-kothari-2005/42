% split_nonempty(+List, -Left, -Right) splits a finite list in input order.
split_nonempty([First, Next | Rest], [First], [Next | Rest]).
split_nonempty([First | Rest], [First | Left], Right) :-
    split_nonempty(Rest, Left, Right).

% apply_operator(+Operator, +Left, +Right, -Value) evaluates integer operands.
apply_operator('+', Left, Right, Value) :-
    Value is Left + Right.
apply_operator('-', Left, Right, Value) :-
    Value is Left - Right.
apply_operator('*', Left, Right, Value) :-
    Value is Left * Right.
apply_operator('/', Left, Right, Value) :-
    Right =\= 0,
    Left mod Right =:= 0,
    Value is Left // Right.

% expression_tree(+Numbers, -Tree, -Value) builds and evaluates one tree per answer.
expression_tree([Number], Number, Number).
expression_tree(Numbers, expr(Operator, LeftTree, RightTree), Value) :-
    split_nonempty(Numbers, LeftNumbers, RightNumbers),
    expression_tree(LeftNumbers, LeftTree, LeftValue),
    expression_tree(RightNumbers, RightTree, RightValue),
    apply_operator(Operator, LeftValue, RightValue, Value).
