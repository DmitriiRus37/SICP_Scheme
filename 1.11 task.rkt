#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (function-rec n)
  (cond ((< n 3) n)
        (else (+
               (function-rec (- n 1))
               (* 2 (function-rec (- n 2)))
               (* 3 (function-rec (- n 3)))
               )
              )
        )
  )

(define (function-iter n)
  (cond
    ((< n 3) n)
    (else (iter 2 1 0 n))
    )
  )
  
(define (iter n1 n2 n3 count)
    (cond ((< count 3) n1)
          (else (iter (+ n1 (* 2 n2) (* 3 n3)) n1 n2 (- count 1)))
          )
  )  

          
