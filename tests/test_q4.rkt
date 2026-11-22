;; test_q4.rkt — S2 test calls
;; Run as: cat code/42_q4.rkt tests/test_q4.rkt > /tmp/42_q4_test.rkt && racket /tmp/42_q4_test.rkt
;; (mimics the grader appending these calls to the solution file)

;; ── Helpers for building large test inputs ───────────────────────────────────

(define (build-flat n)
  (let loop ((i n) (acc '()))
    (if (= i 0)
        acc
        (loop (- i 1) (cons i acc)))))

(define (build-deep d)
  (let loop ((i d) (acc '()))
    (if (= i 0)
        acc
        (loop (- i 1) (list i acc)))))

;; ── PDF examples ─────────────────────────────────────────────────────────────

;; expected: ((42 1 2) (3 4 5) (42 6) (42))
(display (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3))
(newline)

;; expected: ((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))
(display (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3))
(newline)

;; expected: (7)
(display (insert-if-short 7 '() 3))
(newline)

;; expected: ()
(display (insert-if-short 7 '() 0))
(newline)

;; ── Length equal to n (boundary: must NOT insert at that level) ──────────────

;; outer length 3, n=3: no insert at top; (1 2) gets 9, others do not
;; expected: ((9 1 2) (3 4 5) (6 7 8))
(display (insert-if-short 9 '((1 2) (3 4 5) (6 7 8)) 3))
(newline)

;; ── Nested empty lists ────────────────────────────────────────────────────────

;; (() ()) length 2, n=2: no outer insert; each () length 0 < 2 → (5)
;; expected: ((5) (5))
(display (insert-if-short 5 '(() ()) 2))
(newline)

;; ((())) outer length 1 < 3, middle (()) length 1 < 3, inner () length 0 < 3
;; expected: (5 (5 (5)))
(display (insert-if-short 5 '((())) 3))
(newline)

;; ── Custom len-ok? via make-inserter ─────────────────────────────────────────

(define (my-even? n)
  (if (= n 0)
      #t
      (if (= n 1)
          #f
          (my-even? (- n 2)))))

;; Insert 0 wherever length is even
;; outer (a (b c) (d e f) (g h)) length 4 even → insert
;; (b c) length 2 even → insert; (d e f) length 3 odd → no; (g h) length 2 even → insert
;; expected: (0 a (0 b c) (d e f) (0 g h))
(define even-inserter (make-inserter 0 my-even?))
(display (even-inserter '(a (b c) (d e f) (g h))))
(newline)

;; ── Depth-100 stress test ─────────────────────────────────────────────────────

;; Every level has length 1, n=2: insert 'z everywhere.
;; Just verify it terminates and returns a pair.
;; expected: #t
(define deep100 (build-deep 100))
(define deep-result (insert-if-short 'z deep100 2))
(display (pair? deep-result))
(newline)

;; ── Flat list of 10000 elements ───────────────────────────────────────────────

;; length 10000 < 10001: 99 prepended → result length 10001
;; expected: #t #t
(define flat10000 (build-flat 10000))
(define flat-result (insert-if-short 99 flat10000 10001))
(display (= (my-length flat-result) 10001))
(newline)
(display (eq? (car flat-result) 99))
(newline)
