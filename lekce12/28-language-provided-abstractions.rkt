;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 28-language-provided-abstractions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ------- VESTAVĚNÉ ABSTRAKCE -------

;; Programovací jazyky běžně obsahují velmi obecné funkce,
;; které lze často použít místo vytváření vlastní abstrakce.

;; Pro práci s listy jsou běžně abstrahovány funkce
#; (build-list number value-function)

#; (filter predicate list)
#; (map function list)
#; (sort list ordering)

#; (andmap function list)
#; (ormap function list)

#; (foldl operation initial list)
#; (foldr operation initial list)

;; ---- Generování listů ----
;; Funkce build-list má signaturu

; [T]: Number [Number -> T] -> [List-of T]

#; (build-list 4 add1)

; Number -> Posn
; Produces a Posn with coordinates (x, 0)
(define (posn-on-x-axis x)
  (make-posn x 0))

#; (build-list 5 posn-on-x-axis)


;; ---- Převod z listu na jiný list ----
;; Funkce filter má signaturu

; [T]: [T -> Boolean] [List-of T]

#; (filter odd? '(1 2 3 4 5 6 7 8 9))
#; (filter positive? '(-2 -1 0 1 2 3 4))
#; (filter posn? `(#true 10 ,(make-posn 2 5) "a" ,(make-posn 9 1)))


;; Funkce map má signaturu

; [T1 T2]: [T1 -> T2] [List-of T1] -> [List-of T2]

#; (map add1 '(1 2 3 4 5))
#; (map posn-x `(,(make-posn 1 9) ,(make-posn 2 10) ,(make-posn 3 11)))


;; Funkce sort má signaturu

; [T]: [List-of T] [T T -> Boolean] -> [List-of T]

#; (sort '( 7 2 3 9 12 -5 -2) >)
#; (sort '( 7 2 3 9 12 -5 -2) <)
#; (sort '("e" "a" "xyz" "za" "zb") string<?)

; Posn Posn -> Boolean
; Compares x coordinate of posn1 and posn2 (x1 > x2)
(define (ord>-x posn1 posn2)
  (> (posn-x posn1) (posn-x posn2)))

#; (sort `(,(make-posn 7 0) ,(make-posn 3 5) ,(make-posn -2 6) ,(make-posn 6 2))
      ord>-x)


;; ---- Redukce listu na hodnotu ----
;; Funkce andmap a ormap mají signaturu

; [T]: [T -> Boolean] [List-of T] -> Boolean

#; (andmap odd? '(3 5 7 9)) ; true
#; (andmap odd? '(3 5 7 8 9)) ; false

#; (ormap positive? '(-1 0 5)) ; true
#; (ormap positive? '(-1 -2 -3)) ; false


;; Funkce foldl a foldr mají signaturu

; [T1 T2]: [T1 T2 -> T2] T2 [List-of T1] -> T2

#; (foldl + 0 '(5 10 15 20))
#; (foldr + 0 '(5 10 15 20))

#; (foldl string-append ":END" '("a" "b" "c" "d"))
#; (foldr string-append ":END" '("a" "b" "c" "d"))


;; foldl a foldr jsou jedny z "nejsilnějších" abstrakcí - jsou to velmi obecné
;; redukce listů

;; foldl a foldr se liší pořadím aplikace

;; Asociativní operace - nezávisí na pořadí aplikace
;; Paměťová složitost foldr je vyšší (viz. stepper)

;; Poznámka: Některé z těchto funkcí bychom zatím nezvládli nadesignovat
;; (při zachování operační sémantiky)!
;; Vyžadují znalost tzv. akumulátorových parametrů
