#lang racket/base
(require rackunit (only-in (file "../1.5 task.rkt") p [test t]))

(check-equal? (t 0 'anything) 0)
(check-equal? (t 1 'y) 'y)

;; (p) never returns: it is still running after a time limit, then killed.
(define worker (thread (lambda () (p))))
(check-false (sync/timeout 0.2 worker) "(p) loops forever")
(kill-thread worker)
(check-true (thread-dead? worker))
