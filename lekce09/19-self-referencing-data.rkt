;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 19-self-referencing-data) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ----- Data o libovolné velikosti -----

;; Diskuze - slyšeli jste někdy o sebe-referujících datech
;; (data, která obsahují "sama sebe" - stejný typ)?





;; --- List (seznam) ---

;; Diskuze - co je "list" (TODO-list, guest list, shopping list)?
;; Vymyslete další příklady!




;; Reprezentace listů v BSL - pomocí sebe-referujících dat

;; Triviální případ - empty list (prázdný list)
#; '()

;; Konstrukce listu - pomocí funkce cons
#; (cons "Merkur" '())

;; List se skládá z "prvního prvku" (first) a "zbytku listu" (rest)

#;(cons "Venuše" (cons "Merkur" '()))


;; Řekněme že chceme například list pozvaných hostů.
;; Zadefinujme si datový typ

;; ListOfNames is one of
; - '()
; - (cons String ListOfNames)

;; Tato definice obsahuje sama sebe - je sebe-referující!

;; Diskuze - jak vytvořit hodnotu typu ListOfNames? Čím musíme začít?




;; Cvičení - vytvořte hodnotu typu ListOfNames která bude obsahovat alespoň 3 jména

#;(define NAMES
  ...)


; ------------------------------------

;; Poznámka: takovému listu se říká "Linked List"

;; Pojďme se blíže podívat co je
#; '()
;; a co je
#; cons

;; Empty list je pouze konstanta - speciální hodnota reprezentující
;; list neobsahující žádné elementy.

;; BSL obsahuje predikát určující empty list
#; (empty? '()) ; #true
#; (empty? (cons "a" '())) ; #false
#; (empty? "a") ; #false


;; Signatura tohoto predikátu je tedy
; Any -> Boolean

;; cons vypadá jako věc kterou už známe:
;; konstruktor struktury se dvěma polemi.
;; První pole může obsahovat libovolnou
;; hodnotu, druhé pole pak libovolný list.



;; Můžeme zavést ekvivalentní strukturu

; ConsPair is a structure
#; (make-pair Any Any)
; Pair of values
(define-struct pair [left right])


;; ConsPair může obsahovat libovolnou
;; hodnotu i v druhém poli (right)
#; (make-pair "a" '())
#; (make-pair "b" "c")

;; List může v druhém poli obsahovat pouze list
;; je tzv. "checked"
#; (cons "a" '())
#; (cons "b" "c") ; error

;; Poznámka - můžeme vytvořit vlastní
;; checked konstruktor pro ConsPair

; ConsOrEmpty is one of:
; - '()
; - (make-pair Any ConsOrEmpty)

; Any ConsOrEmpty -> ConsOrEmpty
(define (our-cons value list)
  (cond [(empty? list) (make-pair value list)]
        [(pair? list) (make-pair value list)]
        [else (error "our-cons: second argument is not ConsOrEmpty")]))

#;(our-cons "a" '())
#;(our-cons "b" "c")

;; Pokud je cons "checked" konstruktor,
;; pak by struktura kterou vytváří měla mít
;; selektory - stejně jako máme
(define OUR-CONS-VALUE (our-cons "a" '()))
#; (pair-left OUR-CONS-VALUE)
#; (pair-right OUR-CONS-VALUE)

;; Selektory listu se nazývají
#; first
;; a
#; rest

(define LIST-VALUE
  (cons "list"
        (cons "inner list" '())))

#; (first LIST-VALUE)
#; (rest LIST-VALUE)
#; (first (rest LIST-VALUE))


;; ----------------------------------------------

;; Inventář "primitivů" k listům

#; '() ; Empty list
#; empty? ; Predikát který rozpozná empty list
#; cons ; Konstruktor struktur se dvěma polemi (kde druhé pole obsahuje list)
#; first ; Selektor posledního přidaného prvku do listu
#; rest ; Selektor "zbytku" listu ("druhého pole")
#; cons? ; Predikát pro rozpoznání instancí (cons ...)

;; ----------------------------------------------

;; Cvičení - vytvořte list obsahující čísla od 0 do 6 (včetně) v libovolném pořadí.




;; Cvičení - nadesignujte funkci names->list která ze dvou jmen (String) vytvoří list,
;; který tyto jména obsahuje.




;; Cvičení - nadesignujte funkci, append-two-names která připojí dvě jména do již existujícího listu




;; Template pro práci s listy:

;; Template odpovídá tomu, že list
;; 1) je itemizace
;; 2) pokud není empty, tak se chová
;;    jako pár "element" : "zbytek listu"

;; Nejprve provedeme template podle itemizace

; List -> ...
(define (fn.v1 l)
  (cond [(empty? l) ...]
        [(cons? l) ...]))


;; Tento template ale můžeme rozšířit o znalost
;; struktury cons

; List -> ...
(define (fn.v2 l)
  (cond [(empty? l) ...]
        [(cons? l)
         (... (first l) ... (rest l) ...)]))



;; Diskuze - jak pracovat s listy (a dalšími self-referencing daty)?
;; Modelový příklad - design funkce contains-john?

; ListOfNames -> Boolean
; Determines if "John" is in the list-of-names
#;(check-expect (contains-john? (cons "John" (cons "James" '()))) #true)
#;(check-expect (contains-john? (cons "James" (cons "John" '()))) #true)
#;(check-expect (contains-john? (cons "James" (cons "Anna" '()))) #false)
(define (contains-john? list-of-names)
  ...)





;; V rámci template tedy můžeme přidat ještě jedno
;; očekávání - rekurzivní krok

; List -> ...
(define (fn.v3 l)
  (cond [(empty? l) ...]
        [(cons? l)
         (... (first l) ...
              (fn.v3 (rest l)) ...)]))


;; Rekurzivní krok funguje díky přítomnosti
;; tzv. base-case (empty list) který v každém
;; kroku rekurze kontrolujeme.

;; Data vznikla indukcí a naše funkce je
;; konzumuje pomocí rekurze v opačném pořadí,
;; máme tedy matematicky zaručeno, že při
;; takové *rekurzi po struktuře* dojdeme do
;; base-case a rekruze se ukončí.


;; Cvičení - nadesignujte funkci alice-count která spočítá počet
;; stringů "Alice" v ListOfNames




;; Cvičení - nadesignujte funkci how-many která spočítá počet prvků v
;; libovolném listu




;; Cvičení - nadesignujte funkci, která sečte list čísel



