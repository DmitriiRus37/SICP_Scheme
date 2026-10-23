#lang racket/base
;; Exercises 1.22 - 1.28 and the "Fermat test" / "Searching for divisors" notes.
(require rackunit racket/list racket/port "common.rkt"
         (prefix-in p22: (file "../1.22 task.rkt"))
         (prefix-in p23: (file "../1.23 task.rkt"))
         (prefix-in p24: (file "../1.24 task.rkt"))
         (prefix-in p25: (file "../1.25 task.rkt"))
         (prefix-in p26: (file "../1.26 task.rkt"))
         (prefix-in p27: (file "../1.27 task.rkt"))
         (prefix-in p28: (file "../1.28 task.rkt"))
         (prefix-in ft: (file "../Fermat test.rkt"))
         (prefix-in sd: (file "../Searching for divisors.rkt")))

;; the probabilistic tests become reproducible with a fixed seed
(random-seed 20240101)

(define report-line #px"^(\\d+) \\*\\*\\* \\d+(\\.\\d+)?$")

(define (reported-primes lines)
  (for/list ([l lines] #:when (regexp-match? report-line l))
    (string->number (cadr (regexp-match report-line l)))))

;; 1.22: three smallest primes above 1000
(let ([lines (output-lines (lambda () (p22:search-for-prime 1000 3)))])
  (check-equal? (reported-primes lines) '(1009 1013 1019))
  (check-equal? (last lines) "Task done"))
(check-equal? (p22:square 12) 144)
(check-equal? (p22:expmod 2 10 1000) 24)
(check-false (p22:fast-prime? 1001 50))
(check-true (p22:fast-prime? 97 50))
(check-false (p22:timed-prime-test 15))
(check-true (number? (p22:runtime)))

;; 1.23: smallest divisor with the "next" optimisation
(check-equal? (p23:next 2) 3)
(check-equal? (p23:next 3) 5)
(check-equal? (p23:smallest-divisor 199) 199)
(check-equal? (p23:smallest-divisor 1999) 1999)
(check-equal? (p23:smallest-divisor 19999) 7)
(check-true (p23:divides? 7 21))
(check-equal? (p23:square 4) 16)
(check-false (p23:timed-prime-test 21) "composites are not reported")
(check-regexp-match #px"^ \\*\\*\\* \\d+(\\.\\d+)?\n$"
                    (with-output-to-string (lambda () (p23:timed-prime-test 1009))))
(check-true (number? (p23:runtime)))

;; 1.24: Fermat test with many trials
(check-equal? (reported-primes (output-lines (lambda () (p24:search-for-prime 1000 1)))) '(1009))
(check-equal? (reported-primes (output-lines (lambda () (p24:search-for-prime 14 2)))) '(17 19))
(check-false (p24:fast-prime? 1001 20))
(check-equal? (p24:expmod 3 4 5) 1)
(check-equal? (p24:square 3) 9)

;; 1.25: expmod through fast-expt gives the same answers
(check-equal? (p25:fast-expt 2 10) 1024)
(check-equal? (p25:square 6) 36)
(check-equal? (p25:expmod 3 4 5) 1)
(for ([b (in-range 1 10)] [e (in-range 1 10)])
  (check-equal? (p25:expmod b e 7) (p22:expmod b e 7)))
(check-true (p25:fast-prime? 13 10))
(check-false (p25:fast-prime? 91 30))

;; 1.26: tree-recursive expmod (slow but correct)
(check-equal? (p26:expmod 3 4 5) 1)
(check-equal? (p26:square 3) 9)
(check-equal? (reported-primes (output-lines (lambda () (p26:search-for-prime 8 2)))) '(11 13))
(check-false (p26:fast-prime? 21 10))

;; 1.27: Carmichael numbers fool the Fermat test
(for ([n '(561 1105 1729)])
  (check-true (p27:fast-prime? n (- n 1)) (format "~a" n))
  (check-regexp-match #px"^#t \\*\\*\\* " (with-output-to-string (lambda () (p27:timed-prime-test n)))))
(check-false (p27:timed-prime-test 15))
(check-equal? (p27:square 5) 25)
(check-true (number? (p27:runtime)))

;; 1.28: the Miller-Rabin test is not fooled
(for ([n '(561 1105 1729 2465 15)])
  (check-false (p28:timed-prime-test n) (format "~a" n)))
(for ([n '(2 3 13 97 1009)])
  (check-true (p28:timed-prime-test n) (format "~a" n)))
(check-equal? (p28:expmod-new 2 12 13) 1)
(check-equal? (p28:remainder-or-nontrivial-square-root-check 4 15) 0)
(check-equal? (p28:remainder-or-nontrivial-square-root-check 14 15) 1)
(check-equal? (p28:remainder-or-nontrivial-square-root-check 3 15) 9)
(check-true (p28:miller-rabin-test 13 5))
(check-equal? (p28:square 3) 9)

;; Fermat test notes
(check-true (ft:even? 2))
(check-equal? (ft:square 3) 9)
(check-equal? (ft:expmod 2 10 1000) 24)
(check-true (ft:fermat-test 13))
(check-true (ft:fast-prime? 13 5))
(check-false (ft:fast-prime? 1001 50))

;; Searching for divisors notes
(check-equal? (sd:square 3) 9)
(check-equal? (sd:smallest-divisor 199) 199)
(check-equal? (sd:smallest-divisor 19999) 7)
(check-true (sd:divides? 3 9))
(check-equal? (sd:find-divisor 15 2) 3)
(check-equal? (sd:expmod 3 5 7) 5)
(check-equal? (sd:expmod 2 0 7) 1)
