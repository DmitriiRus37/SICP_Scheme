#lang racket/base
(require rackunit
         (prefix-in sq: (file "../1.7 task.rkt"))
         (prefix-in cb: (file "../1.8 task.rkt")))

(check-equal? (sq:square 3) 9)
(check-equal? (sq:average 1 3) 2)
(check-equal? (sq:improve 1 4) 5/2)
(check-true (sq:good-enough? 1.0001 1.0))
(check-false (sq:good-enough? 1.1 1.0))
(check-= (sq:sqrt-iter 1.0 0 2) 1.41421 0.001)
(check-= (sq:sqrt-iter 1.0 0 9) 3 0.001)
;; the relative stop criterion of 1.7 also works for small numbers
(check-= (sq:sqrt-iter 1.0 0 0.0001) 0.01 0.001)

(check-equal? (cb:improve 1 8) 10/3)
(check-true (cb:good-enough? 2.00001 8))
(check-false (cb:good-enough? 2.1 8))
(check-= (cb:cubeitet-iter 1.0 27) 3 0.001)
(check-= (cb:cubeitet-iter 1.0 8) 2 0.001)
