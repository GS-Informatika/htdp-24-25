;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 26-abstraction-of-types) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ------- ABSTRAKCE DATOVÝCH DEFINIC -------

;; Stejně jako jsme repetetivní definice funkcí řešili
;; jejich abstrakcí do jediné funkce s "novou proměnnou",
;; můžeme řešit i repetetivní definice datových typů
;; abstrakcí do parametrizovaných typů.

;; Porovnejte následující definice dat

; List-of-Numbers je jedno z:
; - '()
; - (cons Number List-of-Numbers)


; List-of-Strings je jedno z:
; - '()
; - (cons String List-of-Strings)

;; Jak se tyto definice liší?



;; U datových definic ale nemáme argumenty jako u funkcí!
;; Zatím ...

; [List-of T] je jedno z:
; - '()
; - (cons T [List-of T])

;; Takové definici říkáme "parametrická definice dat"
;; Nyní můžeme dvě předchozí definice (a spoustu dalších)
;; psát jako [List-of Number], [List-of String], [List-of Boolean], ...

;; Funkce které s těmito listy pracují pak obsahují tyto parametrické
;; datové typy ve své signatuře.


; [NE-List-of T] je jedno z:
; - (cons T '())
; - (cons T [NE-List-of T])


; [NE-List-of Number] -> Number
(check-expect (find-max '(1 5 2)) 5)
(define (find-max l)
  (cond [(empty? (rest l)) (first l)]
        [else (max (first l) (find-max (rest l)))]))


(define-struct pair [left right])
; [Pair L R] je struktura:
#; (make-pair L R)
; Obsahuje dvojici hodnot, left a right.

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


;; Funkce mohou pracovat i nad "generickými" (tj. nekonkretizovanými)
;; parametrickými datovými typy. Takové funkce jsou většinou výsledkem
;; abstrakce.

;; Nejprve zapíšeme které parametry budeme používat v naší definici,
;; dále zapíšeme signaturu


; [T]: [T -> Boolean] [List-of T] -> [List-of T]
; Vybere z listu prvky splňující predikát
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

;; Ppokud funkci filter-list použijeme na [List-of Number], pak funkce predicate
;; musí mít signaturu (Number -> Boolean) a výsledkem bude Number.

;; Pokud ji použijeme na [List-of String], za predicate zase musíme doplňit
;; funkci, která z hodnoty String vytvoří Boolean, tedy (String -> Boolean).
;; Výsledkem pak bude Boolean.


;; Je dobré si uvědomit, že signatura funkce je vlastně definice datového typu dané funkce!

;; Další ukázka:


; [T1 T2]: [T1 -> T2] [List-of T1] -> [List-of T2]
; Převede prvky listu list-of-values pomocí mapující funkce fn
(define (map-list fn list-of-values)
  (cond [(empty? list-of-values) '()]
        [else (cons (fn (first list-of-values)) (map-list fn (rest list-of-values)))]))


;; Určete, jaké parametry má tato definice. Vymyslete nějákou konkrétní realizaci
;; této hodnoty (tj. napište nějákou konkretizaci funkce a napište její signaturu)