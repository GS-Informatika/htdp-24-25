;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 26-abstraction-of-types) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ------- ABSTRAKCE DATOVÝCH DEFINIC -------

;; Stejně jako jsme repetetivní definice funkcí řešili
;; jejich abstrakcí do jediné funkce s "novou proměnnou",
;; můžeme řešit i repetetivní definice datových typů
;; abstrakcí do parametrizovaných typů.

;; Porovnejte následující definice dat

; List-of-Numbers is one of:
; - '()
; - (cons Number List-of-Numbers)


; List-of-Strings is one of:
; - '()
; - (cons String List-of-Strings)

;; Jak se tyto definice liší?



;; U datových definic ale nemáme argumenty jako u funkcí!
;; Zatím ...

; [List-of T] is one of:
; - '()
; - (cons T [List-of T])


;; Takové definici říkáme "parametrická definice dat"
;; Nyní můžeme dvě předchozí definice (a spoustu dalších)
;; psát jako [List-of Number], [List-of String], [List-of Boolean], ...

;; Funkce které s těmito listy pracují pak obsahují tyto parametrické
;; datové typy ve své signatuře.


; [NE-List-of T] is one of:
; - (cons T '())
; - (cons T [NE-List-of T])


; [NE-List-of Number] -> Number
(check-expect (find-max '(1 5 2)) 5)
(define (find-max l)
  (cond [(empty? (rest l)) (first l)]
        [(cons? (rest l)) (max (first l) (find-max (rest l)))]))


(define-struct pair [left right])
; [Pair L R] is a struct:
#; (make-pair L R)
; Contains a pair of values - left and right.


;; -------------------------------------------------------------------
;;   Procvičování: Napište funkce pracující nad konkrétními realizacemi
;; parametrického typu [Pair L R] (tedy funkce, kde za L a R dosadíte
;; konkrétní typy). 

;; 1) Funkci která sečte hodnoty v páru čísel




;; 2) Funkci která spojí stringy v páru stringů




;; 3) Funkce, které určí, jestli je hodnota v levém a pravém poli páru
;;    stejná - proveďte pro páry čísel, stringů a Posnů




;; 4) Funkci, která určí jestli je počet znaků v textovém řetězci v
;;    levém poli páru větší, než číslo v pravém poli páru.




; -------------------------------------------------------------------

;; Stejně jako u funkcí, i u datových typů můžeme "vnořovat" parametry.

;; [List-of [Pair L R]] je zápis takového "vnořeného" parametrického typu.


;; -------------------------------------------------------------------
;; Navrhněte funkci sum/lr, která sečte levé a pravé části listu páru čísel:
#; (check-expect (sum/lr (list (make-pair 1 10) (make-pair 2 20)))
                 (make-pair 3 30))




; -------------------------------------------------------------------



