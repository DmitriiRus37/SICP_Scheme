#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (exponent3 b n)
  (cond ((= n 0) 1)
        ((even? n) (square (exponent3 b (/ n 2))))
        (else (* b (exponent3 b (- n 1))))))

(define (even? n) (= (remainder n 2) 0))

(define (square x) (* x x))


(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

(define (halve a) (/ a 2))

(define (double a) (* a 2))

(define (new* a b)
  (cond ((= b 0) 0)
        ((= b 1) a)
        ((even? b)
          (new* (double a) (halve b)))
        (else (+ a (new* a (- b 1))))))

          