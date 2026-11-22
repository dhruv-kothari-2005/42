;; test_q3.rkt — S1 test calls
;; Run as: cat code/42_q3.rkt tests/test_q3.rkt > /tmp/42_q3_test.rkt && racket /tmp/42_q3_test.rkt
;; (mimics the grader appending these calls to the solution file)

;; ── Trees from the assignment PDF ────────────────────────────────────────────

(define t1
  '(4 (2 (1 () ()) (3 () ()))
      (6 (5 () ()) (7 () ()))))

(define t2 '(1 () (2 () (3 () ()))))

(define t3 '(a (b () ()) (c () ())))

(define empty-tree '())

;; ── Additional edge case: single node ────────────────────────────────────────

(define t4 '(9 () ()))

;; ── print-inorder ─────────────────────────────────────────────────────────────
;; Expected:
;;   (1 2 3 4 5 6 7)
;;   ()
(print-inorder t1)
(print-inorder empty-tree)

;; ── print-all-traversals ──────────────────────────────────────────────────────
;; t1 expected:
;;   (1 2 3 4 5 6 7)
;;   (4 2 1 3 6 5 7)
;;   (1 3 2 5 7 6 4)
(print-all-traversals t1)

;; t2 expected:
;;   (1 2 3)
;;   (1 2 3)
;;   (3 2 1)
(print-all-traversals t2)

;; t3 expected:
;;   (b a c)
;;   (a b c)
;;   (b c a)
(print-all-traversals t3)

;; empty tree expected:
;;   ()
;;   ()
;;   ()
(print-all-traversals empty-tree)

;; t4 single-node expected:
;;   (9)
;;   (9)
;;   (9)
(print-all-traversals t4)

;; ── print-height-and-leaves ───────────────────────────────────────────────────
;; Expected:
;;   (3 4)
;;   (3 1)
;;   (2 2)
;;   (0 0)
;;   (1 1)
(print-height-and-leaves t1)
(print-height-and-leaves t2)
(print-height-and-leaves t3)
(print-height-and-leaves empty-tree)
(print-height-and-leaves t4)
