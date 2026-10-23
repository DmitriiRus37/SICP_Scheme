#lang racket/base
;; Helpers shared by the exercise tests.
(require racket/port)
(provide run-module-output output-lines)

;; Instantiates a module in a fresh namespace and returns what it printed.
(define (run-module-output path)
  (parameterize ([current-namespace (make-base-namespace)])
    (with-output-to-string
      (lambda () (dynamic-require path #f)))))

;; Lines printed by thunk.
(define (output-lines thunk)
  (regexp-split #rx"\n" (with-output-to-string thunk)))
