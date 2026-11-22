---
name: prolog-dev
description: Use this for Group 42's Prolog work in CS F301 Assignment 2, including P1 and P2 tests.
---

# Group 42 | Prolog

Use SWI-Prolog 9.x. P1 goes in `code/42_q1.pl` and P2 goes in `code/42_q2.pl`. Do the part asked in the prompt and stop there. Save each problem prompt word for word in its prompt log.

## How we write the code

- Use lowercase names with underscores for predicates and meaningful variables like `Active`, `Solution` and `Equation`.
- Above each predicate, write one short comment saying when it succeeds. For example, `count_solutions(Active, N)` succeeds when N is the number of assignments satisfying the active clues.
- Use only the allowed libraries: `lists`, `apply`, `yall` and `aggregate`. Keep state in arguments. Avoid assert, retract and global variables. Leave out initialization directives and calls to halt.

## Mistakes to check

- In P1, keep the names and atoms exactly as given. Check only the active clues. An assignment can satisfy other clues also. Only main/0 prints, using the four-line format in the sheet.
- In P2, keep the numbers in order. Check exact division and a nonzero divisor at every division node. Evaluate the tree directly.
- An early cut can lose equations on backtracking. Check the full sorted list. Return strings without spaces and keep P2 silent.
- Check brackets on both sides. A right child with equal precedence needs brackets. A left child with equal precedence can be printed directly.

## Before answering

Run from the repo root once the relevant predicate is ready:

```sh
swipl -q -f code/42_q1.pl -g main -t halt
swipl -q -f code/42_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8],N),writeln(N)" -t halt
swipl -q -f code/42_q2.pl -g "all_equations([4,2,5,3],Es),writeln(Es)" -t halt
```

Check the predicate name, number of arguments and output against the PDF. For P2 compare all seven strings and also try an input with no equation. Keep tests in one file per problem under `tests/`. Tell me what you ran and what output you got.