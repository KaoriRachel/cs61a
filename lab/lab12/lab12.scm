
(define-macro (def func args body)
    (list 'define (cons func args) body)
)


(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define all-three-multiples
  (cons-stream 3 (map-stream (lambda (x) (+ x 3)) all-three-multiples))
)


(define (compose-all funcs)
  (if (null? funcs)
      (lambda (x) x)
      (lambda (x) ((compose-all (cdr funcs)) ((car funcs) x)))
  )
)


(define (partial-sums stream)
  (cons-stream (car stream) (add-stream (cdr-stream stream) (partial-sums stream)))
  
)

(define (add-stream stream1 stream2)
  (if (null? stream1)
      nil
      (if (null? stream2)
          nil
          (cons-stream (+ (car stream1) (car stream2)) 
            (add-stream (cdr-stream stream1) (cdr-stream stream2))
          )
      )
  )
)

'''(helper 0 stream)'''