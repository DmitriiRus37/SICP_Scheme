#lang racket
(provide (all-defined-out)) ; exported for tests/

; Exercise 1.29: Simpson's rule
;   h/3 * (y0 + 4y1 + 2y2 + 4y3 + ... + 2y(n-2) + 4y(n-1) + yn),
;   h = (b - a)/n, yk = f(a + kh)

(define (cube x) (* x x x))

(define (simpsons-rule-integral f a b n)
  (integral f a b n 0 (find-h a b n)))

(define (integral func a b n counter h)
  (define (term k) (find-y func a n h k))
  (define (find-next k) (+ k 1))
  (* (/ h 3) (sum term counter find-next n)))

(define (find-h a b n)
  (/ (- b a) n))

; coefficient * yk: 1 for the first and the last point, 4 for odd k, 2 for even k
(define (find-y f a n h counter)
  (let ((y (f (+ a (* counter h)))))
    (cond
      ((or (= counter 0) (= counter n)) y)
      ((even? counter) (* 2 y))
      (else (* 4 y)))))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))
