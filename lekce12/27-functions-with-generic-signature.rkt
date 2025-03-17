;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 27-functions-with-generic-signature) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; -------- GENERIKA --------

;; Funkce mohou pracovat i nad "generickými" (tj. nekonkretizovanými)
;; parametrickými datovými typy. Takové funkce jsou většinou výsledkem
;; abstrakce.

;; Nejprve zapíšeme které parametry budeme používat v naší definici,
;; dále zapíšeme signaturu


; [T]: [T -> Boolean] [List-of T] -> [List-of T]
; Filters list with given predicate
(check-expect (filter-list positive? (list -2 0 4 7 -3)) (list 4 7))
(define (filter-list predicate list-of-values)
  (cond [(empty? list-of-values) '()]
        [(cons? list-of-values)
         (if (predicate (first list-of-values))
             (cons (first list-of-values)
                   (filter-list predicate (rest list-of-values)))
             (filter-list predicate (rest list-of-values)))]))


;; Funkce predicate má datový typ (T -> Boolean).
;; Při konkrétním použití funkce pak musíme dbát na stejnost všech výskytů typu T.

;; Pokud funkci filter-list použijeme na [List-of Number], pak funkce predicate
;; musí mít signaturu (Number -> Boolean) a výsledkem bude Number.

;; Pokud ji použijeme na [List-of String], za predicate zase musíme doplňit
;; funkci, která z hodnoty String vytvoří Boolean, tedy (String -> Boolean).
;; Výsledkem pak bude Boolean.


;; Je dobré si uvědomit, že signatura funkce je vlastně definice datového typu dané funkce!

;; Další ukázka:


; [T1 T2]: [T1 -> T2] [List-of T1] -> [List-of T2]
; Maps members of list-of-values using function fn
(define (map-list fn list-of-values)
  (cond [(empty? list-of-values) '()]
        [(cons? list-of-values)
         (cons (fn (first list-of-values))
               (map-list fn (rest list-of-values)))]))


;; Určete, jaké parametry má tato definice. Vymyslete nějákou konkrétní realizaci
;; této hodnoty (tj. napište nějákou konkretizaci funkce a napište její signaturu)
