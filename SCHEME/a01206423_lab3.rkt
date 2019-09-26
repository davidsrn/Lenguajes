#lang racket
(define (leaf? tree)
  (cond
    [(empty? (cdr tree)) #t]
    [else #f]))

(define (children tree)
  (cdr tree))

(define (deep-all-x? tree x)
  (if (leaf? tree)
      (if (= (car tree) x)
          #t
          #f)
      (deeper-all-x (children tree ) x)))

(define (deeper-all-x  forest x)
  (if (null? forest)
      #t
     (if (deep-all-x? (car forest) x)
        (if (deeper-all-x (cdr forest) x) #t #f) #f)))

(define (deep-reverse1 tree)
  (if (leaf? tree)
      '()
      (deep-reverse-forest (children tree))))

(define (deep-reverse-forest  forest)
  (if (null? forest)
      '()
     (cons (cons (deep-reverse (car forest))
        (deep-reverse-forest (cdr forest))) (car forest))))

(define (invert ls)
  (invh ls '()))

(define (invh ls res)
  (if (null? ls)
      res
      (invh (cdr ls) (cons (car ls) res))))

(define (deep-reverse ls)
  (if (list? ls)
      (invert (map deep-reverse ls))
      ls))

(define (flatten1 tree)
  (if (leaf? tree)
      (car tree)
      (flatten-forest (children tree) (car tree))))

(define (flatten-forest  forest val)
  (if (null? forest)
      '()
     (cons (cons (flatten (car forest))
        (flatten-forest (cdr forest) (car forest))) val)))

(define (flatten ls)
  (cond
    [(null? ls) '()]
    [(list? (car ls)) (append (flatten (car ls)) (flatten (cdr ls)))]
    [else (cons (car ls) (flatten (cdr ls)))]))

(define (count-max-arity1 ls)
  (if (not (list? ls)) 1
  (map(count-leaves ls)) ))

(define (count-leaves tree x)
  (if (leaf? tree)
      0
      (max(length(children tree)) (count-max-arity1 (children tree)))))

(define (max x y)
  (if (> x y)
      x
      y))

(define (count-levels ls)
  (cond
    [(null? ls) 0]
    [(not (list? ls)) 0]
    [else (max (+ 1 (count-levels (car ls)))
               (count-levels (cdr ls)))]))

(define (count-max-arity ls)
  (cah 0 ls))


(define (cah x ls)
  (cond
    [(null? ls) (add1 x)]
    [(list? ls)
     3] ;;Placeholder
    [else x]))



(deep-all-x? '((1) (2) (3)) 1)

(deep-all-x? '((1(1 1)) (1) (1)) 1)

(deep-reverse '((a) ((b) ((c) (d))) (e) ((f) (g))))

(flatten '((a) ((b) ((c) (d))) (e) ((f) (g))))

(count-max-arity '((a) ((b) ((c) (d))) (e) ((f) (g))))
