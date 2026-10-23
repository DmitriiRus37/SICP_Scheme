#lang racket/base
(require rackunit (only-in (file "../1.3 task.rkt") square sum-of-the-squares-of-two-largest))

(check-equal? (square 5) 25)
(for ([args '((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))])
  (check-equal? (apply sum-of-the-squares-of-two-largest args) 13 (format "~a" args)))
(check-equal? (sum-of-the-squares-of-two-largest 2 2 2) 8)
(check-equal? (sum-of-the-squares-of-two-largest 1 1 2) 5)
(check-equal? (sum-of-the-squares-of-two-largest 2 1 1) 5)
(check-equal? (sum-of-the-squares-of-two-largest 1 2 1) 5)
