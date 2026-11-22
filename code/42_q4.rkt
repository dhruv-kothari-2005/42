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

;; my-map : (any -> any) list -> list
;; Applies f to each top-level element of lst in order and returns
;; the new list.  The structure (order and length) is preserved.
(define (my-map f lst)
  (if (null? lst)
      '()
      (cons (f (car lst))
            (my-map f (cdr lst)))))

;; make-inserter : any (number -> bool) -> (list -> list)
;; Returns a one-argument function (call it inserter) that, given a list,
;; inserts x at the front of every list at every nesting level whose
;; top-level length satisfies len-ok?.
;;
;; x and len-ok? are captured by the closure.  The returned inserter never
;; needs to receive x again — it already carries x in its environment.
;; At each list it visits it:
;;   1. measures the original length with my-length,
;;   2. recurses into every element that is itself a list (pair? OR null?),
;;   3. prepends x to the processed list when (len-ok? len) is true.
;;
;; An element is a list if it is either a pair or the empty list.
;; pair? alone misses (), so we use (or (pair? e) (null? e)) to recurse
;; into empty sublists — they have length 0 and may qualify for insertion.
(define (make-inserter x len-ok?)
  (define (inserter lst)
    (let ((len (my-length lst)))
      (let ((processed (my-map (lambda (e)
                                 (if (or (pair? e) (null? e))
                                     (inserter e)
                                     e))
                               lst)))
        (if (len-ok? len)
            (cons x processed)
            processed))))
  inserter)

;; insert-if-short : any list number -> list
;; Inserts x at the front of every list (at every nesting level) whose
;; top-level length, measured BEFORE insertion, is less than n.
;; Defined using make-inserter as required by part c.
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))

;; print-insert-result : -> void
;; Reads x, lst and n from standard input (in that order).
;; Displays the result of (insert-if-short x lst n) followed by a newline.
;; Prints no prompts or any other text.
(define (print-insert-result)
  (let ((x   (read))
        (lst (read))
        (n   (read)))
    (display (insert-if-short x lst n))
    (newline)))
