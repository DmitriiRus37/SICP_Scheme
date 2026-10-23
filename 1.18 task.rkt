#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (halve a) (/ a 2))

(define (double a) (* a 2))

(define (new*-iter a b) (*-iter a b 0 0))

(define (*-iter a b value counter)
  (cond ((or (= a 0) (= b 0)) 0)
         ((= b 1) (+ a value))
         ((even? b) (*-iter (double a) (halve b) value (+ counter 1)))
         (else (*-iter a (- b 1) (+ value a) (+ counter 1)))))