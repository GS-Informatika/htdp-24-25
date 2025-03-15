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
        [else (cons (+ (first l) 5)
                    (add5/list (rest l)))]))

; List-of-Numbers -> List-of-Numbers
(define (add8/list l)
  (cond [(empty? l) '()]
        [else (cons (+ (first l) 8)
                    (add8/list (rest l)))]))

; List-of-Numbers -> List-of-Numbers
(define (multiply5/list l)
  (cond [(empty? l) '()]
        [else (cons (* (first l) 5)
                    (multiply5/list (rest l)))]))



;; Pro abstrakci nad všmi třemi funkcemi najednou v rámci BSL+ si
;; musíme pomoci defunkcionalizací - přidáním reprezentace požadované
;; operace jako hodnoty.

; Operation is one of
; - 'multiply
; - 'add

; List-of-Numbers Operation Number -> List-of-Numbers
(define (operation/list op l num)
  (cond [(empty? l) '()]
        [(eq? op 'multiply) (cons (* (first l) num)
                                  (operation/list op
                                                  (rest l)
                                                  num))]
        [(eq? op 'add) (cons (+ (first l) num)
                             (operation/list op
                                             (rest l)
                                             num))]))

;; Zdá se ale, že jsme jen "přesunuli" opakování dovnitř funkce!
;; Je sice "na jednom místě", ale není to ten nejlepší přístup!

;; Zkusme to ještě jednou! Definujme funkci ve tvaru

; ??? List-of-Number Number -> List-of-Number
(define (operation/list.v2 op l num)
  (cond [(empty? l) '()]
        [else (cons (op (first l) num)
                    (operation/list.v2 op (rest l) num))]))


;; STOP! Zkuste vysvětlit, jaký datový typ má parametr op.
;; Všimněte si jak jej používáme! Má tato definice smysl?

;; V rámci BSL/BSL+ tato definice není sémanticky správná.
;; My se ale nyní přesuneme do ISL (Intermediate Student Language)
;; ve které je toto povoleno.

;; Vyzkoušejme - chceme filtrovat listy podle čísla
;; (vybrat sub-list menších/větších čísel než je nějáké číslo v parametru)

;; Vytvořme nejprve funkce smaller a larger

; Number List-of-Number -> List-of-Number
; Vybere čísla z lon která jsou menší než num
(define (smaller num lon)
  (cond [(empty? lon) '()]
        [(< (first lon) num) (cons (first lon)
                                   (smaller num (rest lon)))]
        [else (smaller num (rest lon))]))


; Number List-of-Number -> List-of-Number
; Vybere čísla z lon která jsou větší než num
(define (larger num lon)
  (cond [(empty? lon) '()]
        [(> (first lon) num) (cons (first lon)
                                   (larger num (rest lon)))]
        [else (larger num (rest lon))]))


;; Nalezněte rozdíly v těchto funkcích a navrhněte abstrakci.
;; Abstrahovanou funkci pojmenujte extract.




;; Definujte funkce smaller.v2 a larger.v2 pomocí abstrahované funkce
;; extract




;; Nejen že je taková definice přehlednější a kratší,
;; ale že můžeme definovat mnohem více "specializovaných" funkcí

; List-of-Numbers Number -> List-of-Numbers
#; (define (equal lon num)
  (extract = lon num))

; List-of-Numbers Number -> List-of-Numbers
#; (define (equal-or-larger lon num)
  (extract >= lon num))


;; Za argument můžeme použít i vlastní funkci, která
;; bude mít správnou signaturu.

; Number Number -> Boolean
; Určí, jestli je (x*x) > c.
(define (sqr>? x c)
  (> (* x x) c))

; List-of-Numbers Number -> List-of-Numbers
#; (define (sqr-larger lon num)
  (extract sqr>? lon num))



;; Abstrahované funkce jsou ve výsledku užitečnější, než specializované!

;; Cvičení
; Infimum a supremum jsou funkce na množinách, které vybírají nejmenší a
;; největší prvek celé množiny.


; NE-List-of-Numbers -> Number
; Nalezne nejmenší číslo v neprázdném listu
(check-expect (inf (list 3 2 7 1 5)) 1)
(check-expect (inf (list 5)) 5)
(define (inf l)
  (cond [(empty? (rest l)) (first l)]
        [else (if (< (first l) (inf (rest l)))
                  (first l)
                  (inf (rest l)))]))


; NE-List-of-Numbers -> Number
; Nalezne největší číslo v neprázdném listu
(check-expect (sup (list 3 2 7 1 5)) 7)
(check-expect (sup (list 5)) 5)
(define (sup l)
  (cond [(empty? (rest l)) (first l)]
        [else (if (> (first l) (sup (rest l)))
                  (first l)
                  (sup (rest l)))]))


;; Definujte funkci (pick-one op l) která bude abstrahovat tyto dvě funkce
;; Vyzkoušejte. Zkuste popsat, jak dlouho se výraz evaluuje v závislosti na
;; délce listu. Dokážete říct proč se funkce takhle chová?





;; Přepište původní funkce za použití funkcí (min x y) a (max x y).
;; Abstrahujte takto přepsané funkce do (pick-one.v2 op l).
;; Proč jsou tyto funkce "rychlejší"?




; -----------------------------------------------------------------------------

;; Efektivně jsme povýšili funkce na "first class citizens" (občany první třídy)
;; Můžeme definovat funkci a následně ji použít jako argument jiné funkce!
;; Funkce jsou v ISL HODNOTY (values)

;; Rozmyslete: jak vypadá datová definice typu pro funkce?





;; Signatura funce = datový typ funkce