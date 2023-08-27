(define (split-at lst n)
  (if (null? lst)
  		(cons nil nil)
  		(if (zero? n)
  				(cons nil lst)
  				(cons (cons (car lst) (car (split-at (cdr lst) (- n 1))))
  							(cdr (split-at (cdr lst) (- n 1)))
  				)
  		)
  )
)


(define-macro (switch expr cases)
	(cons 'cond
		(map (lambda (case) (cons (eq? (car case) (eval expr)) (cdr case)))
    			cases
    )
	)
)

