#lang racket/base
;; "Procedures as Arguments", Euclid's algorithm and exercise 1.29.
(require rackunit
         (prefix-in pa: (file "../Procedures as Arguments.rkt"))
         (prefix-in eu: (file "../Euclid’s Algorithm.rkt"))
         (prefix-in si: (file "../1.29 task.rkt")))

(check-equal? (pa:cube 3) 27)
(check-equal? (pa:inc 1) 2)
(check-equal? (pa:identity 'x) 'x)
(check-equal? (pa:sum-cubes 1 10) 3025)
(check-equal? (pa:sum-integers 1 10) 55)
(check-equal? (pa:sum pa:identity 5 pa:inc 4) 0)
(check-= (pa:integral pa:cube 0 1 0.01) 0.25 0.0001)

(check-equal? (eu:gcd 206 40) 2)
(check-equal? (eu:gcd 7 0) 7)
(check-equal? (eu:gcd 17 5) 1)

;; Simpson's rule is exact for cubes
(check-equal? (si:simpsons-rule-integral si:cube 0 1 100) 1/4)
(check-equal? (si:simpsons-rule-integral si:cube 0 1 1000) 1/4)
(check-equal? (si:simpsons-rule-integral (lambda (x) x) 0 2 4) 2)
(check-= (si:simpsons-rule-integral sin 0 3.141592653589793 100) 2.0 1e-6)
(check-equal? (si:find-h 0 1 4) 1/4)
(check-equal? (si:find-y si:cube 0 4 1/4 0) 0)
(check-equal? (si:find-y si:cube 0 4 1/4 4) 1)
(check-equal? (si:find-y si:cube 0 4 1/4 2) 1/4)
(check-equal? (si:find-y si:cube 0 4 1/4 1) 1/16)
(check-equal? (si:sum si:cube 1 add1 3) 36)
