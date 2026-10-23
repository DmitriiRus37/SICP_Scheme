#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))