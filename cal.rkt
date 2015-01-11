#lang racket/base
(require racket/date)
(require (prefix-in srfidate: srfi/19) )
(require "babawani.rkt")
(provide month-names leapyear? days-in-month monthdays)

(define month-names '["January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December"])


(define (days-in-month m y) 
  (case m 
    [(4 6 9 11)   30]
    [(2) (if (leapyear? y) 29 28)]
    [else 31]
    ))

; if dayn=0; day= Saturday
; if dayn=1; day= Sunday
; if dayn=2; day= Monday
; if dayn=3; day= Tuesday
; if dayn=4; day= Wednesday
; if dayn=5; day= Thursday 
; if dayn=6; day= Friday

;'cal
;;; returns a list of lists of days
;'((31  1  2  3  4  5  6)
;  ( 7  8  9 10 11 12 13)
;  (14 15 16 17 18 19 20)
;  (21 22 23 24 25 26 27)
;  (28  1  2  3  4  5  6))
; 0 for Sunday
(define (monthdays m y) ;> (listof (listof day)
  
  (define dow-first-day (Babwani’s-Algorithm 1 m y))
  ;(define (week-offset d) (modulo (+ d 3) 7)) ; Babwani’s week has saturday=0
  (display (list m y)) (newline)
  (for/list ([w 6]) ; 0-6
    (for/list ([d 7]);0-7
      (define pos (+ (* 7 w) d)) 
      (define dom (+ 1 (- pos dow-first-day))); days are numbered from 1
      (cond
        [(< pos dow-first-day) (- (days-in-month (- m 1) y) dom)]
        [(> dom (days-in-month m y)) (- dom (days-in-month m y))]
        [else dom]
        )
      
      #;(if (>= pos dow-first-day) 
          (if (<= dom (days-in-month m y)) dom (- dom (days-in-month m y)))
          (- (days-in-month (- m 1) y) dom))
      ))
  )

(define (new-date day month year) (make-date 0 0 0 day month year 0 0 #f 0))



;;;test

; (date-day (current-date))
(define reqmonth (date-month  (current-date)))
(define reqyear (date-year (current-date)))

(monthdays reqmonth reqyear)
