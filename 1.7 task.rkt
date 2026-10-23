#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (square x) (* x x))

(define (sqrt-iter guess guess-before x)
  (if (good-enough? guess guess-before)
      guess
      (sqrt-iter (improve guess x) guess x)))

(define (good-enough? guess guess-before)
  (< (abs (- guess guess-before)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) 
  (/ (+ x y) 2))
