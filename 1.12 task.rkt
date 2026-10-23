#lang racket
(provide (all-defined-out)) ; exported for tests/

(define (triangle-element x y)
	(cond ((or (= x 1) (= y 1)) 1)
        (else
			(+ 
				(triangle-element x (- y 1)) 
				(triangle-element (- x 1) y)  
			)
		)
  	)
)