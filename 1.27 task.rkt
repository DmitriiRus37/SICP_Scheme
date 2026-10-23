#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (square n) (* n n))

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

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n (- n 1))
      (report-prime n (- (runtime) start-time))
      false))

(define (report-prime n elapsed-time)
  (display true)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (runtime) (current-inexact-milliseconds))

#|
(list 
   (timed-prime-test 561)
   (timed-prime-test 1105)
   (timed-prime-test 1729)
   (timed-prime-test 2465)
   (timed-prime-test 2821)
   (timed-prime-test 6601))
|#