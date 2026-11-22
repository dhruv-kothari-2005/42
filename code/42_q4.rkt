#lang racket/base

;; S2: Conditionally Insert into a Nested List

;; my-length : list -> number
;; Counts the number of top-level elements in lst.
;; A sublist counts as one element, the same as an atom.
;; The empty list has length 0.
(define (my-length lst)
  (if (null? lst)
      0
      (+ 1 (my-length (cdr lst)))))
