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

% expression_precedence(+Tree, -Precedence) uses larger values for tighter binding.
expression_precedence(expr('+', _, _), 1).
expression_precedence(expr('-', _, _), 1).
expression_precedence(expr('*', _, _), 2).
expression_precedence(expr('/', _, _), 2).
expression_precedence(Number, 3) :-
    integer(Number).

% needs_parentheses(+ParentTree, +Side) succeeds if that child needs parentheses.
needs_parentheses(Parent, left) :-
    Parent = expr(_, Left, _),
    expression_precedence(Parent, ParentPrecedence),
    expression_precedence(Left, LeftPrecedence),
    LeftPrecedence < ParentPrecedence.
needs_parentheses(Parent, right) :-
    Parent = expr(_, _, Right),
    expression_precedence(Parent, ParentPrecedence),
    expression_precedence(Right, RightPrecedence),
    RightPrecedence =< ParentPrecedence.

% expression_string(+Tree, -String) renders a tree in canonical form.
expression_string(Number, String) :-
    integer(Number),
    number_string(Number, String).
expression_string(Tree, String) :-
    Tree = expr(Operator, LeftTree, RightTree),
    expression_string(LeftTree, LeftString),
    expression_string(RightTree, RightString),
    (   needs_parentheses(Tree, left)
    ->  format(string(LeftText), '(~s)', [LeftString])
    ;   LeftText = LeftString
    ),
    (   needs_parentheses(Tree, right)
    ->  format(string(RightText), '(~s)', [RightString])
    ;   RightText = RightString
    ),
    format(string(String), '~s~a~s', [LeftText, Operator, RightText]).
