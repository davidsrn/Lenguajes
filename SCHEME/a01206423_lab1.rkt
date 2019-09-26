#lang racket
;; David Ramirez A01206423
;; function for triangle area
(define (tri-area base alt)
  (/ (* base alt) 2))
;; functions a b and c
(define (a num)
  (+ 10 (* num num)))

(define (b num)
  (+ 20 (* (* num num) (/ 1 2))))

(define (c num)
  (- 2 (/ 1 num)))
;;Tests to understand the language
(define (larger? num1 num2)
  (> num1 num2))

(define (four-a-c a c)
  (* 4 a c))
;; Last exercice declaration
(define (solutions a b c)
  (if (> (* b b) (* 4 a c)) "Two solutions"
      (if (= (* b b) (* 4 a c)) "One Solution" "No solution")))

;;Triangle area test
(tri-area 10 15)

;;Fucntion calls for a b and c
(a 19)

(b 19)

(c 19)

;; Solution test cases
(solutions 1 0 -1)

(solutions 2 4 2)