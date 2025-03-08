;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 23-recuring-auxiliary-functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Dříve jsme narazili na problém jak
;; nadesignovat funkce, které mají
;; změnit pořadí prvků v listu
;; (reverse nebo sort)

;; Template nás dovedl k následujícímu kódu

; List-of-Number -> List-of-Number
; Reverses list of numbers
#;(check-expect (reverse-numbers '()) '())
#;(check-expect (reverse-numbers (cons 1 (cons 2 (cons 3 '()))))
              (cons 3 (cons 2 (cons 1 '()))))
#;(define (reverse-numbers lon)
  (cond [(empty? lon) '()]
        [(cons? lon) (... (first lon) ...
                          (reverse-numbers (rest lon)))]))


;; Potřebujeme ale najít vztah mezi "otočeným zbytkem listu"
;; a prvním prvkem a správně jej zde aplikovat.

;; Řešením je vytvořit funkci, která vezme hodnotu a
;; vloží jí na konec listu (jako poslední prvek).

; Number List-of-Number -> List-of-Number
; Inserts value as the last member of the list
(check-expect (insert-at-end 1 '()) (list 1))
(check-expect (insert-at-end 5 (list 1 2 3 4)) (list 1 2 3 4 5))
(define (insert-at-end value list)
  (cond [(empty? list) (cons value '())]
        [(cons? list) (cons (first list)
                            (insert-at-end value (rest list)))]))


;; Pomocí této pomocné funkce (auxiliary function)
;; můžeme jednoduše dokončit definici reverse-numbers.

;; Využijeme kontraktu který nám obě funkce dávají.

;; Funkce reverse-numbers nám říká, že list který
;; vyprodukuje bude v opačném pořadí než
;; list který do této funkce vešel.

;; Tento kontrakt platí i v rámci rekurzivního volání.

;; Funkce inset-at-end nám zase říká, že pouze vezme
;; hodnotu a vloží ji na konec listu, který jinak
;; nezmění.

;; Kombinace
#;(insert-at-end (first lon) (reverse-number (rest lon)))
;; tedy vezme už otočený seznam zbytku lon a první
;; číslo v lon vloží na jeho konec - ve výsledku
;; tedy stále dostaneme reversed list!


;; Design problem

;; Navrhněme podobným způsobem funkci,
;; která seřadí list čísel od nejmenšího
;; po největší.

; List-of-Number -> List-of-Number
; Sorts list of numbers in an ascending order.
#;(check-expect (sort-numbers '()) '())
#;(check-expect (sort-numbers (list 5 1 2 3)) (list 1 2 3 5))
(define (sort-numbers lon)
  (cond [(empty? lon) '()]
        [(cons? lon) (... (first lon)
                          ... (sort-numbers (rest lon)))]))


;; Nyní víme, že máme seřazený list (sort-numbers (rest lon))
;; a máme prvek (first lon).




;; Musíme tedy do seřazeného listu vložit prvek tak,
;; aby list zůstal seřazený.

;; K tomu napíšeme pomocnou funkci

; Number List-of-Number -> List-of-Number
; Inserts value into ascending sorted list in a way
; the result is also sorted.
(check-expect (insert-sorted 1 '()) (cons 1 '()))
(check-expect (insert-sorted 1 (list 2 3 4 5)) (list 1 2 3 4 5))
(check-expect (insert-sorted 5 (list 1 2 3 4)) (list 1 2 3 4 5))
(define (insert-sorted n slon)
  (cond [(empty? slon) (cons n '())]
        [(cons? slon) (if (> n (first slon))
                          ; n larger - insert in rest of list
                          (cons (first slon)
                                (insert-sorted n (rest slon)))
                          ; n <= - insert at beginning
                          (cons n slon))]))

;; Tuto funkci nyní můžeme použít uvnitř definice sort-numbers
;; a dostáváme algoritmus "insert sort".
