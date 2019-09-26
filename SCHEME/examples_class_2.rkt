#lang racket
(define (cube num)
  (* num num num))

(define cubel(lambda (x) (* x (* x x))))

(define (op fun x y z)
  (if (> x 0) (fun x) "negative")
  (if (> y 0) (fun y) "negative")
  (if (> z 0) (fun z) "negative")
  )

(define (op1 fun x y z)
  (fun
   (if (> x 0) x 1)
   (if (> y 0) y 1)
   (if (> z 0) z 1)))


(op1 (lambda (x y z) (* x y z)) 4 4 2)
;(cube 2)

;(cubel 2)
