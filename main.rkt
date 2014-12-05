#lang racket/gui

;; (c) 2015 K. Shah & S. De Gabrielle
(require racket/date
         (prefix-in srfi/19: srfi/19)
         "cal.rkt")

;(define month-names '["January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December"])
;
;(define (leapyear? y)
;  (or (and (= (modulo y 100) 0) (not (= (modulo y 400) 0))) ; not leap
;      (= (modulo y 4) 0)))
;
;(define (days-in-month m y) 
;  (case m 
;  [(4 6 9 11)   30]
;  [(2) (if (leapyear? y) 29 28)]
;  [else 31]
;  ))
(define m 1)
(define y 2014)
(define d 15)

(define (days-in-month-list m y) 
  (for/list ([i (days-in-month m y)]) (number->string i)))

;; '["1" "2" "3" "4" "5" "6" "31"]

(define day-in-seconds (* 60 60 24))
(define week-in-seconds (* day-in-seconds 7))

;; (calc-breach-date referral-date) -> breach-date
(define (calc-breach-date referral-date) ;-> referral date + 18 weeks and one day.
  (define 18weeks1dayinseconds (+ (* week-in-seconds 18) day-in-seconds))
  (seconds->date (+ (date->seconds referral-date) 18weeks1dayinseconds)))




(define 18weeks (new frame% (label "18 Weeks calculator") [width 500] [height 200]))

(define today (new text-field%   [label "today:"]
                   [parent 18weeks]))

(define breach (new text-field%   [label "Breach:"]
                    [parent 18weeks]))

(define referal-date-panel (new horizontal-panel% [parent 18weeks]))

(define referral-date-day (new choice% [label "day"] [choices (days-in-month-list m y) ]
                               [parent referal-date-panel]
                               [callback (λ (c e) (set! d (send c get-selection)) )]
                               ))

;(send c get-string (send c get-selection))

(define referral-date-month (new choice%  [label "month"] [choices month-names]
                               [callback (λ (c e) (set! m (send c get-selection)) )]
                                 [parent referal-date-panel]))

(define referral-date-year (new  choice%  [label "year"] [choices '["2013" "2014"]]
                               [callback (λ (c e) (set! y (string->number 
                                                           (send c get-string (send c get-selection)))) )]
                                 [parent referal-date-panel]))

(send today set-value (date->string (current-date)))


(send today set-value (date->string (current-date)))
(send breach set-value (date->string (calc-breach-date (current-date))))

[send 18weeks show #t]
