#lang racket/base
(require rackunit (only-in (file "../1.2.2.rkt") change cc value))

(check-equal? (change 100) 292)
(check-equal? (change 0) 1)
(check-equal? (change 11) 4)
(check-equal? (cc 10 0) 0)
(check-equal? (cc -1 5) 0)
(check-equal? (map value '(1 2 3 4 5)) '(1 5 10 25 50))
