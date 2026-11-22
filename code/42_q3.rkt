#lang racket/base

(provide inorder-helper
         preorder-helper
         postorder-helper
         tree-height
         leaf-count
         print-inorder
         print-all-traversals
         print-height-and-leaves)

;; S1: Binary Tree Traversals
;; A tree is either () or (value left right).
;; value is a number or a single-character symbol.
;; Accessors: (car tree) = value, (cadr tree) = left, (caddr tree) = right.

;; ── Traversal helpers ────────────────────────────────────────────────────────
;;
;; All three helpers use an accumulator (acc) so that append is never needed.
;; acc holds the values that must come AFTER the current subtree in the final
;; output list.  Recursion unwinds from right to left, building the list by
;; consing onto acc.

;; inorder-helper : tree list -> list
;; Returns the inorder (Left Node Right) value list.
;; Strategy: recurse into the right subtree first to build the right suffix,
;; then cons the root, then recurse into the left subtree using that as acc.
(define (inorder-helper tree acc)
  (if (null? tree)
      acc
      (inorder-helper
       (cadr tree)
       (cons (car tree)
             (inorder-helper (caddr tree) acc)))))

;; preorder-helper : tree list -> list
;; Returns the preorder (Node Left Right) value list.
;; Strategy: recurse into the right subtree to build the right suffix,
;; then recurse into the left subtree using that as acc,
;; then cons the root on front.
(define (preorder-helper tree acc)
  (if (null? tree)
      acc
      (cons (car tree)
            (preorder-helper
             (cadr tree)
             (preorder-helper (caddr tree) acc)))))

;; postorder-helper : tree list -> list
;; Returns the postorder (Left Right Node) value list.
;; Strategy: recurse into the right subtree using (cons root acc) as acc,
;; so the root lands after all right-subtree values; then recurse into the
;; left subtree so left values come first.
(define (postorder-helper tree acc)
  (if (null? tree)
      acc
      (postorder-helper
       (cadr tree)
       (postorder-helper
        (caddr tree)
        (cons (car tree) acc)))))

;; ── Height and leaf helpers ───────────────────────────────────────────────────

;; tree-height : tree -> number
;; Height of () is 0.  Height of a node is 1 + max(height(left), height(right)).
(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1 (max (tree-height (cadr tree))
                 (tree-height (caddr tree))))))

;; leaf-count : tree -> number
;; A leaf is a node whose left and right subtrees are both ().
;; The empty tree has no leaves.
(define (leaf-count tree)
  (if (null? tree)
      0
      (if (and (null? (cadr tree)) (null? (caddr tree)))
          1
          (+ (leaf-count (cadr tree))
             (leaf-count (caddr tree))))))

;; ── Required functions ────────────────────────────────────────────────────────

;; S1.a
;; print-inorder : tree -> void
;; Prints the inorder value list on one line, then a newline.
(define (print-inorder tree)
  (display (inorder-helper tree '()))
  (newline))

;; S1.b
;; print-all-traversals : tree -> void
;; Prints three lines: inorder, preorder, postorder.
(define (print-all-traversals tree)
  (display (inorder-helper tree '()))
  (newline)
  (display (preorder-helper tree '()))
  (newline)
  (display (postorder-helper tree '()))
  (newline))

;; S1.c
;; print-height-and-leaves : tree -> void
;; Prints the list (height leaf-count) on one line, then a newline.
(define (print-height-and-leaves tree)
  (display (list (tree-height tree) (leaf-count tree)))
  (newline))
