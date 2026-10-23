#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond
    ((= times 0) true)
    ((fermat-test n) (fast-prime? n (- times 1)))
    (else false)))

;(define (expmod base exp m)
;  (cond ((= exp 0) 1)
;        ((even? exp)
;        (remainder (square (expmod base (/ exp 2) m))
;          m))
;        (else
;         (remainder (* base (expmod base (- exp 1) m))
;          m))))

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

(define (square n) (* n n))

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))