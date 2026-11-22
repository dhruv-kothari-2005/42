---
name: scheme-dev
description: Use this for Group 42's Racket work in CS F301 Assignment 2, including S1 and S2 tests.
---

# Group 42 | Scheme

Use Racket 8.x. Start `code/42_q3.rkt` and `code/42_q4.rkt` with `#lang racket/base`. Do one function or one test file at a time. Save each problem prompt word for word in its prompt log.

## How we write the code

- Use names like `my-length` and keep the function names from the PDF. Above each function, explain the base case and what the smaller recursive call gives back. For a wrapper, say what it prints or returns.
- Pass state through arguments. Use tail recursion where it fits. Keep the submitted files definitions-only. The grader adds the calls.

## Which built-ins can we use?

- Forms: `define`, `lambda`, `let`, `let*`, `letrec`, named `let`, `if`, `cond` with `else`, `and`, `or`, `not`, `begin`, and quote written as `'`.
- Lists: `cons`, `car`, `cdr`, `list`, and compositions of car and cdr up to four levels. Also `null?`, `pair?`, `eq?`, `assq`, and `assoc`.
- Numbers and output: `+`, `-`, `*`, `<`, `>`, `<=`, `>=`, `=`, `max`, `display`, and `newline`. Only S2 can also use `read`.

## Mistakes to check

- Check every built-in against the list above. It is easy to use length, append, reverse, map or list? out of habit. Write a helper using the allowed operations if needed.
- In S1, the empty tree has height 0 and no leaves. A node with one child is not a leaf. Check the traversal order with a tree whose left and right values differ.
- In S2, count each list's original top-level elements. A nested list counts as one element. Check for an empty sublist as well as a nonempty pair. Use strict less than. Keep one final definition of insert-if-short using make-inserter.

## Before answering

Run these from the repo root. Both files should load silently:

```sh
racket code/42_q3.rkt
racket code/42_q4.rkt
```

Test actual calls on a temporary copy like the grader does. For example, this S2 check should print `(7)` on one line:

```sh
tmp=$(mktemp)
cp code/42_q4.rkt "$tmp"
printf '\n(print-insert-result)\n' >> "$tmp"
printf '7 () 3\n' | racket "$tmp"
rm "$tmp"
```

For S1, append a call to print-height-and-leaves on the empty tree to a temporary copy and check for `(0 0)` followed by a newline. Keep one test file per problem under `tests/`. Check exact output, including newlines. For S2 also test depth 100 and a flat list of 10,000 elements. Tell me which cases you actually ran.