#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (exponent1 b n)
  (if (= n 0)
      1
      (* b (exponent1 b (- n 1)))))

(define (exponent2 b n) 
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b (- counter 1) (* b product))))

(define (exponent3 b n)
  (cond ((= n 0) 1)
        ((even? n) (square (exponent3 b (/ n 2))))
        (else (* b (exponent3 b (- n 1))))))

(define (even? n) (= (remainder n 2) 0))

(define (square x) (* x x))

(define (exponent4 b n)
  (new-version 1 b n))

(define (new-version prod b n)
  (cond ((= n 0) prod)
        ((even? n)  (new-version prod (square b) (/ n 2)))
        (else (new-version (* prod b) b (- n 1)))))