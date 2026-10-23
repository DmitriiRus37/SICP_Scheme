#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (even? n) (= (remainder n 2) 0))

(define (square n) (* n n))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) 
         (fast-prime? n (- times 1)))
        (else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp denominator)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) denominator))
          denominator))
        (else
         (remainder 
          (* base (expmod base (- exp 1) denominator))
          denominator))))

