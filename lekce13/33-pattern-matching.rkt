;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 33-pattern-matching) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; PATTERN MATCHING

;; Modul 2htdp/abstraction
(require 2htdp/abstraction)
;; kromě syntaxe pro iterace obsahuje
;; i syntax pro tzv. pattern matching.

;; Pro itemizace jsme vždy používali stejný
;; template - pro každou možnost jsme
;; formulovali predikát a poté použili
;; vhodné selektory.

;; Tento template jsme aplikovali stále dokola
;; a jak víme, repetice si žádá abstrakci.
;; Abstrakci predikát-selektor template ale
;; nemůžeme udělat sami - taková abstrakce musí
;; být zavedena v rámci programovacího jazyka.

;; Designeři funkcionálních jazyků ale potřebu
;; této abstrakce rozumí a typický funkcionální jazyk
;; (jako je třeba Racket, Haskell, OCaml, F#)
;; takovou abstrakci obsahují - pattern matching.
;; V ISL+ tuto abstrakci máme poskytnutou modulem
;; abstraction.
(define (example value)
  (match value
    [0 "Zero"]
    [(cons f r) (string-append "A list with "
                               (number->string (add1 (length r)))
                               " members")]
    [(posn x y) (string-append "A posn ("
                               (number->string x) ", "
                               (number->string y) ")")]
    [(? positive?) "A postive number"]
    [x "Some other value"]))

#; (example (list 1 2 3))

; [List-of Number] -> [List-of Number]
(check-expect (take-until-zero (list 0 1 2 3))
              '())
(check-expect (take-until-zero (list -1 2 0 3 4))
              (list -1 2))
(check-expect (take-until-zero (list 1 2 3 4))
              (list 1 2 3 4))
(define (take-until-zero list)
  (match list
    [(? empty?) '()]
    [(cons 0 rest) '()]
    [(cons x rest) (cons x (take-until-zero rest))]))


;; Pattern matching můžeme použít na
;; 1) Nahrazení cond -> je lépe vidět vůči které
;;    struktuře testujeme
;; 2) Nahrazení dekonstrukce struktur -> je jednodušší
;;    použít hodnoty ze struktur

; Posn -> Number
(check-expect (distance-from-zero (make-posn 0 1)) 1)
(check-expect (distance-from-zero (make-posn 1 0)) 1)
(check-expect (distance-from-zero (make-posn 3 4)) 5)
(define (distance-from-zero p)
  (match p
    [(posn x y) (sqrt (+ (sqr x) (sqr y)))]))

;; Nemusíme používat explicitně selektory, match uvnitř
;; (posn x y) klauzule "binduje" proměnné x a y,
;; můžeme je pak použít.


;; Můžeme mít i vnořený match

; Posn Posn -> Number
; Determines euclidean distance between two positions
(check-expect (distance (make-posn 1 1)
                        (make-posn 2 1)) 1)
(check-expect (distance (make-posn 1 1)
                        (make-posn 1 2)) 1)
(check-expect (distance (make-posn 1 1)
                        (make-posn 4 5)) 5)
(define (distance p1 p2)
  (match p1
    [(posn x1 y1) ; p1 rozložíme na x1 a y1
     (match p2
       [(posn x2 y2) ; p2 rozložíme na x2 a y2
        (sqrt (+ (sqr (- x1 x2))
                 (sqr (- y1 y2))))])]))
                    

