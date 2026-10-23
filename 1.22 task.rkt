#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (search-for-prime from how-many)
  (search from how-many)
)

(define (search from how-many)
  (if (= how-many 0)
      (display "Task done")
      (if (odd? from) 
          (if (timed-prime-test from)
               (search (+ 2 from) (- how-many 1))
               (search (+ 2 from) how-many))
          (search (+ 1 from) how-many))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond
    ((= times 0) true)
    ((fermat-test n) (fast-prime? n (- times 1)))
    (else false)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
          m))))

(define (square n) (* n n))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n (- n 1))
      (report-prime n (- (runtime) start-time))
      false))

(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (runtime) (current-inexact-milliseconds))