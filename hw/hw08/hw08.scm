(define (rle s)
  (define (rle-stream str pre num)
    (if (null? str) (cons-stream (list pre num) nil)
      (if (eq? (car str) pre)
          (rle-stream (cdr-stream str) pre (+ num 1))
          (cons-stream (list pre num) (rle-stream (cdr-stream str) (car str) 1))
      )
    )
  )
  (if (null? s) nil
      (rle-stream (cdr-stream s) (car s) 1)
  )
)

(define (group-by-nondecreasing s)
  (define (nd-stream str pre pre_stream)
    (if (null? str)
        (cons-stream pre_stream nil)
        (if (< (car str) pre)
            (cons-stream pre_stream (nd-stream (cdr-stream str) (car str) (cons (car s) nil)))
            (nd-stream (cdr-stream str) (car str) (append pre_stream (cons (car str) nil)))
        )
    )
  )
  (if (null? s) nil
      (nd-stream (cdr-stream s) (car s) (cons (car s) nil))
  )
)


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))
