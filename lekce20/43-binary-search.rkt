;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 43-binary-search) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Binární vyhledávání

;; S binárním vyhledáváním jsme se
;; setkali u BST. Znali jsme seřazení
;; prvků ve struktuře a využili jej
;; k rychlému nalezení daného prvku.
;; Tento princip můžeme využít i mimo
;; strukturu stromu.

;; Sample problem:
;; Vyhledávání kořenů funkce

;; Kořen funkce f(x) je číslo x_0
;; pro které platí f(x_0) = 0.

;; Nalezení takové hodnoty umíme pro lineární
;; a kvadratické funkce, případně pro speciální hodnoty
;; složitějších funkcí.

;; Obecné řešení tohoto problému je
;; složitější. Matematická analýza nám
;; poskytuje "Bolzanovu větu":

;; Pokud f(a)f(b) < 0, pak existuje
;; alespoň jeden bod c, pro který f(c) = 0.


;; Bolzanova věta je důsledkem "intermediate value theorem":
;; Spojitá funkce na intervalu [a, b] nabývá všech
;; hodnot mezi [f(a), f(b)].

;; Tato věta nám dává podmínku pro existenci kořene:
;; musíme najít 2 hodnoty a, b pro které platí f(a)f(b) < 0.
;; Pak je kořen x_0 funkce f někde v intervalu (a, b).


;; Přesné řešení nemusí být počítačem reprezentovatelné,
;; budeme hledat přibližné řešení - x'_0 pro které platí
;; |x'_0 - x_0| < epsilon.
;; Podmínka pro triviální řešení tedy bude
;; |a - b| < epsilon

;; K triviálnímu řešení se dostaneme tak, že budeme
;; dělit interval prohledávání na poloviny a aplikujeme
;; Bolzanovu větu.


(define epsilon 0.00001)

; [Number -> Number] Number Number -> Number
; Nalezne přibližný kořen funkce f
; Předpokládá že f je spojitá a
#; (or (<= (f left) 0 (f right))
       (<= (f right) 0 (f left)))
; Rozdělí interval na poloviny, kořen je v jednom
; z podintervalů - tom který splňuje podmínku výše
(define (root f left right)
  (cond [(< (- right left) epsilon) left]
        [else (local ((define mid
                        (/ (+ left right) 2))
                      (define f@mid (f mid))
                      (define f@left (f left))
                      (define f@right (f right)))
                (cond [(or (<= f@left 0 f@mid)
                           (<= f@mid 0 f@left))
                       (root f left mid)]
                      [(or (<= f@right 0 f@mid)
                           (<= f@mid 0 f@right))
                       (root f mid right)]))]))


;; Binární vyhledávání kořene je numerická
;; metoda výpočtu - pomocí počítače a
;; opakované aplikace algoritmu dostáváme
;; přibližný výsledek.


;; Další numerické metody
;;  - Hledání kořene
;;    - Newtonova metoda
;;  - Výpočet integrálu:
;;    - Trapezoid rule
;;    - Simpsonovo pravidlo
;;  - Řešení diferenciálních rovnic
;;    - Eulerova metoda
;;    - Runge-Kutta metody
;;  - Hledání řešení soustav lineárních rovnic
;;    - Gaussova eliminace
;;  - Interpolace
;;    - Lagrangeova interpolace
