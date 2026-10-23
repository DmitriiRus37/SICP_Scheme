#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (change sum)
  (cc sum 5)
  )

(define (cc sum coins)
  (cond ((= sum 0) 1)
        ((or (< sum 0) (= coins 0)) 0)
        (else (+ (cc sum (- coins 1)) (cc (- sum (value coins)) coins)))))


(define (value coins)
   (cond ((= coins 1) 1)
         ((= coins 2) 5)
         ((= coins 3) 10)
         ((= coins 4) 25)
         ((= coins 5) 50)))