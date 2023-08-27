(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cdr (cdr s)))
)


(define (sign num)
  (cond ((< num 0) -1)
        ((= num 0) 0)
        ((> num 0) 1)
  )
)


(define (square x) (* x x))

(define (pow x y)
  (if (= y 1) x
    (if (odd? y) (* x (square (pow x (/ (- y 1) 2))))
      (square (pow x (/ y 2)))
    )
  )
)


(define (unique s)
  (if (null? s) nil
    (cons (car s) (unique (filter (lambda (x) (not (eq? (car s) x))) (cdr s))))
  )
)


(define (replicate x n)
  (define (replocate_reverse x n s)
    (if (zero? n) s
        (replocate_reverse x (- n 1) (cons x s))
    )
  )
  (replocate_reverse x n nil)
)


(define (accumulate combiner start n term)
  (define (accumulating start n cur)
    (if (zero? n) start
        (accumulating (combiner start (term n)) (- n 1) (+ cur 1))
    )
  )
  (accumulating start n 1)
)


(define (accumulate-tail combiner start n term)
  (define (accumulating start n cur)
    (if (zero? n) start
        (accumulating (combiner start (term n)) (- n 1) (+ cur 1))
    )
  )
  (accumulating start n 1)
)


(define-macro (list-of map-expr for var in lst if filter-expr)
  (list 'map 
    (list 'lambda (list var) map-expr) 
    (list 'filter (list 'lambda (list var) filter-expr) lst) 
  )
)

(define (map f s)
  (if (null? s) 
      ()
      (cons(f (car s)) (map f (cdr s)))
  )
)

(define (filter f s)
  (if (null? s)
      ()
      (if (f (car s))
          (cons (car s) (filter f (cdr s)))
          (filter f (cdr s))
      )
  )
)