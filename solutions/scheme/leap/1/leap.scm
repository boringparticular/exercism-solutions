(import (rnrs))

(define (leap-year? year)
  (cond ((eqv? (modulo year 400) 0) #t)
        ((eqv? (modulo year 100) 0) #f)
        ((eqv? (modulo year 4) 0) #t)
        (else #f)))

