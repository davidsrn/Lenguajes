#lang racket
(define nombre (list 'D 'a 'v 'i 'd '_ 'R 'a 'm 'i 'r 'e 'z))

(define (ret-last name)
  (if (eq? '_ (car name))
      (count-last (cdr name) 1)
      (ret-last (cdr name))))

(define (count-last name pos)
  (if (= pos 5)
      (car name)
      (count-last (cdr name) (+ pos 1))))


;; ((lambda (x) (ret-last x)) nombre)


(define (fibH n)
  (cond
    [(< n 1) 0]
    [(= n 1) 1 ]
    [else (+ (fibH (- n 2)) (fibH(- n 1)))]))

(define (fibT n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))