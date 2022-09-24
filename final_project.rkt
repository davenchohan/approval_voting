#lang racket

;CMPT 383 Final Project
;Written by: Daven Chohan
;Student Id: 301401324

;; Returns true if x is in lst, and false otherwise. (Taken from the Class Notes)
(define (contains x lst)
  (cond [(empty? lst)           #f]
        [(equal? x (first lst)) #t]
        [else (contains x (rest lst))]
        )
  )

(define (count-fn1 pred? lst) ;learned from the class notes
  (cond [(empty? lst) 0]
        [(pred? (first lst))
         (+ 1 (count-fn1 pred? (rest lst)))]
        [else (count-fn1 pred? (rest lst))]))

(define occurs
  (lambda (x lst)
    (count-fn1 (curry equal? x) lst)))

(define (pairs lst1 lst2) ;from my assignment 1
  (cond [(empty? lst1) '()]
        [(empty? lst2) '()]
        [else (cons (list (first lst1) (first lst2))
                    (pairs (rest lst1) (rest lst2)))]
        )
  )

(define (bigger-number i j)
  (> (first i) (first j))
  )

 (define (sort-greatest lst)
   (sort lst bigger-number))

(define (print-lst lst)
  (cond [(empty? lst) '()]
        [(empty? (rest lst)) (cons
                              (first(rest (first lst)))
                              (first(first lst)))]
        [else (flatten(list (cons
                             (first(rest (first lst)))
                             (first(first lst)))
                             (print-lst (rest lst))))]
        )
  )

(define (display-it x y)
  (display x)
  (display ":")
  (displayln y)
  )

(define (display-lst lst)
  (cond [(empty? lst) '()]
        [(empty? (rest(rest lst)))
         (display-it (first lst) (first(rest lst)))]
        [else (display-it (first lst) (first(rest lst)))
              (display-lst (rest (rest lst)))]
        )
  )

;From my assignment 1
 (define (my-remove-duplicates lst)
   (cond [(empty? lst) '()]
         [(not(list? lst)) (list lst)]
         [(if (contains (first lst) (rest lst))
              (my-remove-duplicates (rest lst))
              (cons (first lst)
                    (my-remove-duplicates (rest lst)))
              )
          ]
         )
   )

(define (occurscheck x lst)
     (cond [(empty? lst) '()]
           [(empty? x) '()]
           [else (flatten(list (occurs (first x) lst)
                               (occurscheck (rest x) lst)))]
      )
   )

(define lst2 '());To get all the votes from every ballot
(define allCandidates '())
(define (main)
  (define empties 0) ;To get the number of empty ballots
  (define ballots 0) ;To get the number of total ballots
  (define full 0) ;To get the number of full ballots
  (displayln "What is the name of the ballot file?")
  (define address (read-line))
  (define textFile (file->lines address))
  (set! ballots (length textFile))
  (displayln " ")
  (set! lst2 (filter (lambda (x) (not(equal? '("none") x)))
                     (map my-remove-duplicates
                          (map string-split textFile))))
  (set! empties (length (filter (lambda (x) (equal? '("none") x)) (map string-split textFile))))
  (set! allCandidates (my-remove-duplicates(flatten lst2)))
  (display "Total # of ballots: ")
  (displayln ballots)
  (displayln " ")
  (display-lst (print-lst (sort-greatest (pairs (occurscheck
            allCandidates (flatten lst2))
            allCandidates))))
  (displayln " ")
  (display "empty: ")
  (displayln empties)
  (display "full: ")
  (displayln (length (filter (lambda (x) (equal? (length allCandidates) (length x))) lst2)))
  )



