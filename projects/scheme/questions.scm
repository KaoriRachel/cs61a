(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (zip pairs)
  (define (zip-pair pair s q)
      (if (null? pair) (list s q)
        (zip-pair (cdr pair) (append s (list (caar pair))) (append q (list (car (cdar pair)))))
      )
  )
  (zip-pair pairs nil nil)
)

;; Problem 16
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 16
    (define (enumerate-index s num)
       (if (null? s) nil
           (cons (cons num (cons (car s) nil)) (enumerate-index (cdr s) (+ num 1)))
       )
    )
    (enumerate-index s 0)
  )
  ; END PROBLEM 16

;; Problem 17
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 17
  (if (zero? total) '(())
    (if (null? denoms) nil
      (if (< total (car denoms))
          (list-change total (cdr denoms))
          (append (cons-all (car denoms) (list-change (- total (car denoms)) denoms))
                  (list-change total (cdr denoms))
          )
      )
    )
  )
)

(define (cons-all adder s)
  (map (lambda (x) (cons adder x)) s
  )
)
  ; END PROBLEM 17

;; Problem 18
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (append (list form params) (map (lambda (x) (let-to-lambda x)) body))
           ; END PROBLEM 18
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (append (list (list 'lambda (car (zip values)) (car (map (lambda (x) (let-to-lambda x)) body))))
                   (map (lambda (x) (let-to-lambda x)) (cadr (zip values))))
           ; END PROBLEM 18
           ))
        (else
         ; BEGIN PROBLEM 18
         (map (lambda (x) (let-to-lambda x)) expr)
         ; END PROBLEM 18
         )))