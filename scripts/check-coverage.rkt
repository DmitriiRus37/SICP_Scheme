#lang racket/base
;; Runs tests/ under raco cover's instrumentation and fails when line coverage
;; of the exercise files (*.rkt in the repository root) is below a minimum
;; (raco cover itself has no fail-under option).
;;
;; usage: racket scripts/check-coverage.rkt [minimum-percent]   (default 90)
;;
;; A line counts as relevant when it contains code cover can instrument; it is
;; covered when none of its code is reported as uncovered.
(require cover racket/file racket/list racket/path racket/runtime-path)

(define-runtime-path root "..")

(define minimum
  (let ([args (current-command-line-arguments)])
    (if (zero? (vector-length args)) 90 (string->number (vector-ref args 0)))))

(define (real->decimal-string* x)
  (string-append (number->string (/ (round (* 10 (exact->inexact x))) 10)) "%"))

(define (rkt-files dir)
  (sort (for/list ([p (directory-list dir #:build? #t)]
                   #:when (and (file-exists? p)
                               (equal? (path-get-extension p) #".rkt")))
          (path->string (simplify-path (path->complete-path p))))
        string<?))

(define sources (rkt-files root))
(define tests (rkt-files (build-path root "tests")))

(define passed? (apply test-files! (append sources tests)))
(define coverage (get-test-coverage))

(define (line-stats file)
  (define text (file->string file))
  ;; positions are 1-based character offsets
  (define-values (relevant covered)
    (for/fold ([relevant 0] [covered 0])
              ([line (in-list (regexp-split #rx"\n" text))]
               [start (in-list (let loop ([lines (regexp-split #rx"\n" text)] [pos 1] [acc '()])
                                 (if (null? lines)
                                     (reverse acc)
                                     (loop (cdr lines) (+ pos (string-length (car lines)) 1)
                                           (cons pos acc)))))])
      (define states
        (for/list ([i (in-range (string-length line))]
                   #:unless (char-whitespace? (string-ref line i)))
          (coverage file (+ start i))))
      (cond [(not (or (memq 'covered states) (memq 'uncovered states))) (values relevant covered)]
            [(memq 'uncovered states) (values (add1 relevant) covered)]
            [else (values (add1 relevant) (add1 covered))])))
  (values relevant covered))

(define-values (total-relevant total-covered)
  (for/fold ([r 0] [c 0]) ([file (in-list sources)])
    (define-values (fr fc) (line-stats file))
    (printf "~a ~a/~a lines  ~a\n"
            (if (zero? fr) "100.0%" (real->decimal-string* (* 100 (/ fc fr))))
            fc fr (file-name-from-path file))
    (values (+ r fr) (+ c fc))))

(define percent (if (zero? total-relevant) 100 (* 100. (/ total-covered total-relevant))))
(printf "\nLine coverage: ~a/~a = ~a (minimum ~a%)\n"
        total-covered total-relevant (real->decimal-string* percent) minimum)

(unless passed?
  (eprintf "Some tests failed.\n")
  (exit 1))
(when (< percent minimum)
  (eprintf "Line coverage ~a is below the required ~a%.\n" (real->decimal-string* percent) minimum)
  (exit 1))
