#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (timed-prime-test n)
  (start-prime-test n))

(define (start-prime-test n)
  (define (fast-prime? n times)
    (cond ((= times 0) true)
          ((miller-rabin-test n times) 
           (fast-prime? n (- times 1)))
          (else false)))
  (fast-prime? n (- n 1)))

(define (miller-rabin-test n times)
  (= (expmod-new times (- n 1) n) 1))

(define (expmod-new base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
        ; (remainder (square (expmod base (/ exp 2) m)) m))
         (remainder-or-nontrivial-square-root-check (expmod-new base (/ exp 2) m) m))
        (else (remainder
               (* base (expmod-new base (- exp 1) m))
               m))))

(define (remainder-or-nontrivial-square-root-check rem n)
  (if (and
       (not (or
             (= rem 1)
             (= rem (- n 1))))
       (= (remainder (square rem) n) 1))
      0
      (remainder (square rem) n)))

(define (square n) (* n n))



