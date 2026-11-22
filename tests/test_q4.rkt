#lang racket/base
(require "../code/42_q4.rkt")

;; ── Helpers for building large test inputs (test file only) ──────────────────
;; These use define and named let which are permitted.
;; They are NOT part of the solution file.

;; build-flat : number -> list
;; Builds a flat list (1 2 3 ... n) for stress testing.
(define (build-flat n)
  (let loop ((i n) (acc '()))
    (if (= i 0)
        acc
        (loop (- i 1) (cons i acc)))))

;; build-deep : number -> nested list
;; Builds a singly-nested list to depth d: (1 (2 (3 ... (d) ...)))
;; Each level is a one-element list containing the next level.
(define (build-deep d)
  (let loop ((i d) (acc '()))
    (if (= i 0)
        acc
        (loop (- i 1) (list i acc)))))

;; ── PDF examples ─────────────────────────────────────────────────────────────

;; 42 ((1 2) (3 4 5) (6) ()) 3  →  ((42 1 2) (3 4 5) (42 6) (42))
(display (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3))
(newline)

;; 0 (((1) 2) (3) ((4 5 6) ())) 3  →  ((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))
(display (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3))
(newline)

;; 7 () 3  →  (7)
(display (insert-if-short 7 '() 3))
(newline)

;; 7 () 0  →  ()
(display (insert-if-short 7 '() 0))
(newline)

;; ── Length equal to n (boundary: must NOT insert) ────────────────────────────

;; outer list has length 3, n = 3: 3 < 3 is false, no insert at top level
;; inner (1 2) has length 2, 2 < 3 true → (9 1 2)
;; inner (3 4 5) has length 3, 3 < 3 false → (3 4 5)
;; inner (6 7 8) has length 3, 3 < 3 false → (6 7 8)
;; expected: ((9 1 2) (3 4 5) (6 7 8))
(display (insert-if-short 9 '((1 2) (3 4 5) (6 7 8)) 3))
(newline)

;; ── Nested empty lists ────────────────────────────────────────────────────────

;; () inside a list: () has length 0, 0 < 2 true → (5)
;; (() ()) has length 2, 2 < 2 false → no outer insert, but each () gets 5
;; expected: ((5) (5))
(display (insert-if-short 5 '(() ()) 2))
(newline)

;; Deeply nested empty: ((()))
;; outer ((())) length 1, 1 < 3 true → (5 ...)
;; middle (()) length 1, 1 < 3 true → (5 ...)
;; inner () length 0, 0 < 3 true → (5)
;; expected: (5 (5 (5)))
(display (insert-if-short 5 '((())) 3))
(newline)

;; ── Custom len-ok? via make-inserter ─────────────────────────────────────────

;; my-even? : number -> bool
;; Returns true if n is even, using only permitted built-ins.
;; Counts down by 2: even if it reaches 0, odd if it reaches 1.
(define (my-even? n)
  (if (= n 0)
      #t
      (if (= n 1)
          #f
          (my-even? (- n 2)))))

;; Insert 0 wherever length is even (0, 2, 4, ...)
;; lst = (a (b c) (d e f) (g h))
;; outer length 4, even → insert
;; (b c) length 2, even → insert
;; (d e f) length 3, odd → no insert
;; (g h) length 2, even → insert
;; expected: (0 a (0 b c) (d e f) (0 g h))
(define even-inserter (make-inserter 0 my-even?))
(display (even-inserter '(a (b c) (d e f) (g h))))
(newline)

;; ── Depth-100 stress test ─────────────────────────────────────────────────────

;; build-deep 100 gives a chain: (1 (2 (3 ... (100) ...)))
;; Every level is a one-element list (length 1).
;; With n = 2: 1 < 2 is true at every level, so x = 'z is inserted everywhere.
;; We just check it completes without error and the result is a pair.
(define deep100 (build-deep 100))
(define deep-result (insert-if-short 'z deep100 2))
(display (pair? deep-result))   ; expected: #t
(newline)

;; ── Flat list of 10000 elements ───────────────────────────────────────────────

;; flat10000 has length 10000.
;; With n = 10001: 10000 < 10001 true → x = 99 inserted at top level.
;; No sublists, so no recursion beyond the top level.
;; Result length = 10001 (99 prepended).
;; We check the first element and the total length via my-length.
(define flat10000 (build-flat 10000))
(define flat-result (insert-if-short 99 flat10000 10001))
(display (= (my-length flat-result) 10001))  ; expected: #t
(newline)
(display (eq? (car flat-result) 99))          ; expected: #t
(newline)
