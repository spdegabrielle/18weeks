#lang racket/base
(require racket/date)
(require (prefix-in srfidate: srfi/19) )
(require "babawani.rkt")
(provide month-names leapyear? days-in-month monthdays)
         
(define month-names '["January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December"])

(define (leapyear? y)
  (or (and (= (modulo y 100) 0) (not (= (modulo y 400) 0))) ; not leap
      (= (modulo y 4) 0)))

(define (days-in-month m y) 
  (case m 
  [(4 6 9 11)   30]
  [(2) (if (leapyear? y) 29 28)]
  [else 31]
  ))

;'cal
;;; returns a list of lists of days
;'((31  1  2  3  4  5  6)
;  ( 7  8  9 10 11 12 13)
;  (14 15 16 17 18 19 20)
;  (21 22 23 24 25 26 27)
;  (28  1  2  3  4  5  6))
; 0 for Sunday
(define (monthdays m y) ;> (listof (listof day)
  (display (list m y)) 
  (define dow-first-day (Babwani’s-Algorithm 1 m y))
  ;(for)
  
  (define (first-day m y)
    (make-date m y 1) 
    
    )
  void)
  
  
  ;;;test
  
  ; (date-day (current-date))
  (define reqmonth (date-month  (current-date)))
  (define reqyear (date-year (current-date)))
  
  (monthdays reqmonth reqyear)
