;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10-designing-functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Jakmile dokázeme definovat data
;; (umíme reprezentovat informaci na vstupu
;; a interpretovat data na výstupu)
;; a umíme s jejich pomocí anotovat funkce
;; (přidat kontext k výpočtu který funkce provádí
;; pomocí signatury funkce),
;; můžeme psaní funkcí zformalizovat
;; do jednoduchého procesu.

;; ---- DESIGN RECIPE ----

; 1) Doplňme definice datových typů, které
;;  funkce konzumuje nebo produkuje.

; 2) Zapíšeme
;;   a) Signaturu funkce
;;   b) Účel funkce
;;   c) Hlavičku funkce

;;  Signatura je kontrakt, kterým říkáme
;;  co funkce konzumuje a produkuje za data.

;;  Účel funkce je krátký komentář, kde je popsáno
;;  "co je výsledkem funkce?".
;;  Každý, kdo čte váš program by měl porozumět
;;  co funkce produkuje bez čtení její implementace.

;;  Hlavička funkce je pak první krok v implementaci:
;;  Zápis (define ...) syntaxe bez implementace těla funkce.
;;  Pro každou konzumovanou hodnotu zvolíme vhodné jméno,
;;  jako tělo funkce zatím zvolíme jednoduchou hodnotu
;;  typu, který má funkce produkovat.


; String Number Image -> Image
; Inserts text of text-size to image img.
(define (add-text text text-size img)
  ...)


; 3) Ukažme použití funkce na příkladech
;; vstupů a očekávaných výstupů.

; Number -> Number
; Computes area of a square with side len
; given 2, expect 4
; given 9, expect 81
#;(define (area-of-square len) 0)


; 4) Nyní nás čeká implementace funkce. Začneme
;; s tzv. inventářem. Uvědomíme si, jaké hodnoty
;; máme dostupné (argumenty co funkce konzumuje).
;; Napíšeme šablonu funkce - template, která bude
;; odpovídat tomu, jak se ze vstupních dat dostaneme
;; k výsledku.

; Number -> Number
; Computes area of a square with side len
; given 2, expect 4
; given 9, expect 81
#;(define (area-of-square len)
    (... len ...))

;; Zatím je template docela nudný, brzy si ale
;; ukážeme zajímavější šablony, které budou
;; vystihovat složitější data se kterými
;; budeme pracovat.

; 5) Coding time! Nyní je čas na implementaci!
;; Šablonu doplníme o algoritmus (pracující na datech
;; na vstupu).


; Number -> Number
; Computes area of a square with side len
; given 2, expect 4
; given 9, expect 81
(define (area-of-square len)
    (sqr len))

; 6) Testování! Je třeba zkontrolovat, jestli je
;; naše implementace správná. Prozatím použijeme
;; tlačítko Run a v oblasti interakcí vyzkoušíme
;; například hodnoty v ukázkce použití, pro
;; ověření implementace. Brzy se naučíme psát
;; automatické testy, které nahradí ukázky použití.

;; Pokud výsledek testování neodpovídá očekávanému
;; výsledku, nastávají 3 možnosti:
;;  a) Špatně jste určili očekávaný výsledek v ukázce
;;     použití.

;;  b) Implementace funkce je špatně -> vytvořili jste
;;     bug.

;;  c) Špatně je jak ukázka použití, tak i implementace
;;     funkce (není obvyklé, ale stává se)