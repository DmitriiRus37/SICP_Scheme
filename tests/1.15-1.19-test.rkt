#lang racket/base
(require rackunit
         (prefix-in s: (file "../1.15 task.rkt"))
         (prefix-in e16: (file "../1.16 task.rkt"))
         (prefix-in ex: (file "../Exponentiation.rkt"))
         (prefix-in m: (file "../1.17 task.rkt"))
         (prefix-in i: (file "../1.18 task.rkt"))
         (only-in (file "../1.19 task.rkt") fib fib-iter))

;; 1.15
(check-equal? (s:cube 3) 27)
(check-equal? (s:p 1) -1)
(check-equal? (s:sine 0.05) 0.05)
(check-= (s:sine 12.15) -0.39980 0.0001)
(check-= (s:sine 1.0) (sin 1.0) 0.001)

;; 1.16 and Exponentiation: four ways to compute b^n
(for* ([prefix (list (list e16:exponent1 e16:exponent2 e16:exponent3 e16:exponent4)
                     (list ex:exponent1 ex:exponent2 ex:exponent3 ex:exponent4))]
       [exponent prefix])
  (check-equal? (exponent 2 10) 1024)
  (check-equal? (exponent 3 0) 1)
  (check-equal? (exponent 3 5) 243)
  (check-equal? (exponent 5 7) 78125))
(check-true (e16:even? 4))
(check-false (ex:even? 5))
(check-equal? (ex:square 7) 49)
(check-equal? (e16:expt-iter 2 3 1) 8)
(check-equal? (ex:new-version 1 2 5) 32)

;; 1.17: multiplication by repeated addition and by doubling/halving
(check-equal? (m:* 6 7) 42)
(check-equal? (m:* 6 0) 0)
(check-equal? (m:double 21) 42)
(check-equal? (m:halve 42) 21)
(check-equal? (m:square 9) 81)
(check-true (m:even? 10))
(check-equal? (m:exponent3 2 10) 1024)
(check-equal? (m:exponent3 3 3) 27)
(check-equal? (m:new* 6 0) 0)
(check-equal? (m:new* 6 1) 6)
(check-equal? (m:new* 6 7) 42)
(check-equal? (m:new* 13 16) 208)
(for* ([a 10] [b 10])
  (check-equal? (m:new* a b) (* a b)))

;; 1.18: iterative version
(check-equal? (i:double 4) 8)
(check-equal? (i:halve 8) 4)
(check-equal? (i:new*-iter 0 5) 0)
(check-equal? (i:new*-iter 5 0) 0)
(for* ([a (in-range 1 12)] [b (in-range 1 12)])
  (check-equal? (i:new*-iter a b) (* a b)))

;; 1.19: logarithmic Fibonacci
(check-equal? (for/list ([n 11]) (fib n)) '(0 1 1 2 3 5 8 13 21 34 55))
(check-equal? (fib 100) 354224848179261915075)
(check-equal? (fib-iter 1 0 0 1 1) 1)
