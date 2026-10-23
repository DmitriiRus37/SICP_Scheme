#lang racket/base
(require rackunit
         (only-in (file "../1.10 task.rkt") A)
         (only-in (file "../1.11 task.rkt") function-rec function-iter iter)
         (prefix-in t12: (file "../1.12 task.rkt"))
         (prefix-in t13: (file "../1.13 task.rkt")))

;; Ackermann's function
(check-equal? (A 0 5) 10)
(check-equal? (A 2 0) 0)
(check-equal? (A 1 10) 1024)
(check-equal? (A 2 4) 65536)
(check-equal? (A 3 3) 65536)

;; f(n) = n for n < 3, f(n-1) + 2f(n-2) + 3f(n-3) otherwise
(define expected '(0 1 2 4 11 25 59 142 335 796 1892))
(for ([n (in-naturals)] [f expected])
  (check-equal? (function-rec n) f (format "rec ~a" n))
  (check-equal? (function-iter n) f (format "iter ~a" n)))
(check-equal? (iter 2 1 0 2) 2)

;; Pascal's triangle
(for ([triangle-element (list t12:triangle-element t13:triangle-element)])
  (check-equal? (triangle-element 1 5) 1)
  (check-equal? (triangle-element 5 1) 1)
  (check-equal? (triangle-element 2 2) 2)
  (check-equal? (triangle-element 3 3) 6)
  (check-equal? (triangle-element 5 5) 70))
