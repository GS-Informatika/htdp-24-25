;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 21-lists-in-signatures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Funkce produkující a
;; konzumující listy


;; a) Generování listů z hodnot

; T -> List-of-T

;; Procházením dat T vytváříme list hodnot T
;; Procházení může být i rekurze na typu T

; Number -> List-of-Number
; Creates list of numbers from n to 0
(check-expect (make-lon 0) (cons 0 '()))
(check-expect (make-lon 2) (cons 2 (cons 1 (cons 0 '()))))
(define (make-lon n)
  (cond [(zero? n) (cons n '())]
        [(number? n) (cons n (make-lon (sub1 n)))]))

; String Number -> List-of-String
; Creates list of n copies of string s
(check-expect (copy "a" 0) '())
(check-expect (copy "" 1) (cons "" '()))
(check-expect (copy "a" 2) (cons "a" (cons "a" '())))
(define (copy s n)
  (cond [(zero? n) '()]
        [(number? n) (cons s (copy s (sub1 n)))]))


;; Cvičení

;; b) Vytvoření hodnoty z listu hodnot (agregace)

; List-of-T -> T

; obecná operace - fold/reduce

; Number List-of-Number -> Number
; Adds all numbers from the list to number n
(check-expect (add-numbers-to 0 '()) 0)
(check-expect (add-numbers-to 0 (cons 1 '())) 1)
(check-expect (add-numbers-to 1 (cons 1 '())) 2)
(check-expect (add-numbers-to 0 (cons 1 (cons 2 (cons 3 '())))) 6)
(define (add-numbers-to n lon)
  (cond [(empty? lon) n]
        [(cons? lon) (+ (first lon)
                        (add-numbers-to n (rest lon)))]))


;; Cvičení
(require 2htdp/batch-io)

;; 1) Modul 2htdp/batch-io obsahuje funkce,
;;    které dokáží číst soubory nejen jako string,
;;    ale i jako listy hodnot (písmen, slov, řádků...).
;;    Použíjte vhodnou funkci z tohoto modulu a
;;    nadesignujte program wc (word count) který určí
;;    počet slov (1Stringů) v souboru.
;;    Pokud máte Unix systém, můžete porovnat s "wc -w"
;;    Unix programem.





;; c) Generování listů z jiných listů

; List-of-T1 -> List-of-T2

;; Kanonické operace - změna pořadí, map, filter

;; map -> převedení každého prvku na jiný pomocí funkce

; List-of-String -> List-of-Number
; Maps list of strings to list of given string lengths
(check-expect (strings-lengths '()) '())
(check-expect (strings-lengths (cons "" '()))
              (cons 0 '()))
(check-expect (strings-lengths (cons "a" (cons "ab" '())))
              (cons 1 (cons 2 '())))
(define (strings-lengths los)
  (cond [(empty? los) '()]
        [(cons? los) (cons (string-length (first los))
                           (strings-lengths (rest los)))]))

;; filter -> zachování pouze některých prvků podle predikátu

; List-of-Number -> List-of-PositiveNumber
; Filters list leaving only positive numbers
(check-expect (filter-positive '()) '())
(check-expect (filter-positive (cons 0 '()))
              '())
(check-expect (filter-positive (cons 1 (cons -1 '())))
              (cons 1 '()))
(check-expect (filter-positive (cons -1 (cons 2 '())))
              (cons 2 '()))
(define (filter-positive lon)
  (cond [(empty? lon) '()]
        [(cons? lon) (if (positive? (first lon))
                         (cons (first lon)
                               (filter-positive (rest lon)))
                         (filter-positive (rest lon)))]))


; Změna pořadí - reverse, sort

; List-of-Number -> List-of-Number
; Reverses list of numbers
#;(check-expect (reverse-numbers '()) '())
#;(check-expect (reverse-numbers (cons 1 (cons 2 (cons 3 '()))))
              (cons 3 (cons 2 (cons 1 '()))))
(define (reverse-numbers lon)
  (cond [(empty? lon) '()]
        [(cons? lon) (... (first lon) ...
                          (reverse-numbers (rest lon)))]))

;; Pomocí jednoduché rekurze tento problém nevyřešíme!
;; Budeme muset zavést pomocnou rekurzivní funkci a použít
;; design by contract.
;; To samé pro sorting.
;; Ukážeme si později...
