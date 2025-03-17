;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 25-higher-order-function) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Zatím jsme dokázali abstrahovat konkrétní hodnotu
;; do parametru. Funkce ale mohou mít i jiný typ
;; podobnosti, který můžeme chtít abstrahovat.

;; Popište rozdíly mezi funkcemi. Navrhněte abstrakci.

; List-of-Numbers -> List-of-Numbers
(define (add5/list l)
  (cond [(empty? l) '()]
        [(cons? l) (cons (+ (first l) 5)
                    (add5/list (rest l)))]))

; List-of-Numbers -> List-of-Numbers
(define (add8/list l)
  (cond [(empty? l) '()]
        [(cons? l) (cons (+ (first l) 8)
                    (add8/list (rest l)))]))

; List-of-Numbers -> List-of-Numbers
(define (multiply5/list l)
  (cond [(empty? l) '()]
        [(cons? l) (cons (* (first l) 5)
                    (multiply5/list (rest l)))]))











;; Pro abstrakci nad všmi třemi funkcemi najednou v rámci BSL+ si
;; musíme pomoci defunkcionalizací - přidáním reprezentace požadované
;; operace jako hodnoty.

; Operation is one of
; - "multiply"
; - "add"

; Operation List-of-Numbers Number -> List-of-Numbers
(define (operation/list op l num)
  (cond [(empty? l) '()]
        [(cons? l) (cond 
                     [(string=? op "multiply")
                      (cons (* (first l) num)
                            (operation/list op
                                            (rest l)
                                            num))]
                     [(string=? op "add")
                      (cons (+ (first l) num)
                            (operation/list op
                                            (rest l)
                                            num))])]))

;; Zdá se ale, že jsme jen "přesunuli" opakování dovnitř funkce!
;; Je sice "na jednom místě", ale není to ten nejlepší přístup!
;; Je to navíc docela rozsáhlá funkce - lepší by přece bylo:

; List-of-Numbers Number -> List-of-Numbers
(define (add/list l n)
  (cond [(empty? l) '()]
        [(cons? l) (cons (+ (first l) n)
                         (add/list (rest l) n))]))

; List-of-Numbers Number -> List-of-Numbers
(define (multiply/list l n)
  (cond [(empty? l) '()]
        [(cons? l) (cons (* (first l) n)
                         (add/list (rest l) n))]))

; Operation List-of-Numbers Number -> List-of-Numbers
(define (operation/list.v1.5 op l num)
  (cond [(string=? op "multiply") (multiply/list l num)]
        [(string=? op "add") (add/list l num)]))

;; A máme zase původní problém - dvě velmi podobné funkce!


;; Zkusme to jinak - stejně jako jsme
;; abstrahovali podobnosti v hodnotách uvnitř
;; funkce.

;; Definujme funkci

; ??? List-of-Number Number -> List-of-Number
(define (operation/list.v2 op l num)
  (cond [(empty? l) '()]
        [(cons? l) (cons (op (first l) num)
                         (operation/list.v2 op (rest l) num))]))


;; STOP! Zkuste vysvětlit, jaký datový typ má parametr op.
;; Všimněte si jak jej používáme! Má tato definice smysl?





;; V rámci BSL/BSL+ tato definice není sémanticky správná.
;; My se ale nyní přesuneme do ISL (Intermediate Student Language)
;; ve které je toto povoleno.

;; Funkcím, které konzumují jiné funkce jako parametry se říká
;; funkce vyššího řádu (higher order functions)

;; Vyzkoušejme - chceme filtrovat listy podle čísla
;; (vybrat sub-list menších/větších čísel než je nějáké číslo v parametru)

;; Vytvořme nejprve funkce smaller a larger

; Number List-of-Number -> List-of-Number
; Filters number smaller than num from list lon.
(define (smaller num lon)
  (cond [(empty? lon) '()]
        [(cons? lon) (if (< (first lon) num)
                         (cons (first lon)
                               (larger num (rest lon)))
                         (larger num (rest lon)))]))


; Number List-of-Number -> List-of-Number
; Filters number larger than num from list lon.
(define (larger num lon)
  (cond [(empty? lon) '()]
        [(cons? lon) (if (> (first lon) num)
                         (cons (first lon)
                               (larger num (rest lon)))
                         (larger num (rest lon)))]))


;; Nalezněte rozdíly v těchto funkcích a navrhněte abstrakci.
;; Abstrahovanou funkci pojmenujte extract.





;; Definujte funkce smaller.v2 a larger.v2 pomocí abstrahované funkce
;; extract





;; Nejen že je taková definice přehlednější a kratší,
;; ale že můžeme definovat mnohem více "specializovaných" funkcí

; List-of-Numbers Number -> List-of-Numbers
#;(define (equal lon num)
  (extract = lon num))

; List-of-Numbers Number -> List-of-Numbers
#;(define (equal-or-larger lon num)
  (extract >= lon num))


;; Za argument můžeme použít i vlastní funkci, která
;; bude mít správnou signaturu.

; Number Number -> Boolean
; Determines if square of x is larger than c ((x*x) > c).
(define (sqr>? x c)
  (> (* x x) c))

; List-of-Numbers Number -> List-of-Numbers
#;(define (sqr-larger lon num)
  (extract sqr>? num lon))



;; Abstrahované funkce jsou ve výsledku užitečnější, než specializované!


; -----------------------------------------------------------------------------

;; Efektivně jsme povýšili funkce na "first class citizens" (občany první třídy)
;; Můžeme definovat funkci a následně ji použít jako argument jiné funkce!
;; Funkce jsou v ISL HODNOTY (values)

;; Rozmyslete: jak vypadá datová definice typu pro funkce?





;; Signatura funce = datový typ funkce