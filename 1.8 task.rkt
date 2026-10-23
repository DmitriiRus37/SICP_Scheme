#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (cubeitet-iter guess x)
  (if (good-enough? guess x)
      guess
      (cubeitet-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (* guess guess guess) x)) 0.001))

(define (improve guess x)
  (/ (+ (/ x (* guess guess))
        (* 2 guess))
     3))

