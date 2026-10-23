#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

; (test 0 (p)) never returns under applicative-order evaluation: the
; argument (p) is evaluated first and loops forever. Kept as a comment so
; the module can be loaded (see tests/1.5-test.rkt).
; (test 0 (p))