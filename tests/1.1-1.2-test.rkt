#lang racket/base
(require rackunit racket/runtime-path "common.rkt"
         (only-in (file "../1.1 task.rkt") a b))

(define-runtime-path task-1.1 "../1.1 task.rkt")
(define-runtime-path task-1.2 "../1.2 task.rkt")

(check-equal? a 3)
(check-equal? b 4)

(check-equal? (run-module-output task-1.1)
              "10\n12\n8\n3\n6\n19\n#f\n4\n16\n6\n16\n")

(check-equal? (run-module-output task-1.2) "-37/150\n")
