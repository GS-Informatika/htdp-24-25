;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 31-lambdas) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; LAMBDA FUNKCE (Anonymní funkce)


;; Při použití abstrakcí používáme funkce jako argumenty.
;; Často se jedná o předdefinované funkce, funkce z knihoven,
;; nebo funkce které jsou již definované dříve v kódu.
;; Někdy ale potřebujeme definovat krátkou a jednoduchou funkci,
;; kterou jinde v kódu nevyužijeme.

;; Pro tento účel nám mohou dobře sloužit lokální definice,
;; pro velmi jednoduché funkce ale zbytečně zabírají příliš
;; místa v kódu, který se pak hůře čte


(define-struct item [name price])
; Item is a struct:
#; (make-item String Number)
; Represents item in a shop inventory.


; [List-of Item] Number -> [List-of Item]
; Extracts list of items that are cheaper than threshold
(check-expect (cheap-items (list (make-item "A" 10) (make-item "B" 15)) 12)
              (list (make-item "A" 10)))
(define (cheap-items items threshold)
  (local (; Item -> Boolean
          (define (cheaper? item)
            (> threshold (item-price item))))
    (filter cheaper? items)))


;; Programátoři by měli být schopni vytvářet podobné malé a
;; nesignifikantní funkce mnohem jednodušeji. Potřebujeme
;; tedy vylepšit programovací jazyk.

;; Přejdemě do jazyka ISL+lambda, který tento problém řeší
;; konceptem anonymních (bezejmených) / lambda funkcí

; [List-of Item] Number -> [List-of Item]
; Extracts list of items that are cheaper than threshold
(check-expect (cheap-items.v2 (list (make-item "A" 10) (make-item "B" 15)) 12)
              (list (make-item "A" 10)))
(define (cheap-items.v2 items threshold)
  (filter (lambda (i) (> threshold (item-price i)))
          items))


;; Syntax lambda funkcí je přímočarý

#; (lambda (proměnná1 proměnná2 ...) výraz)

#; (lambda (x) (+ x 10))
#; (lambda (s1 s2) (string-append s1 " " s2))

;; Výraz lambda vytvoří funkci kterou lze přímo aplikovat

#; ((lambda (x) (+ x 10)) 5)
#; ((lambda (s1 s2) (string-append s1 " " s2)) "string1" "string2")


;; Cvičení
;; 1) Napište lambda funkci která vynásobí číslo dvěmi




;; 2) Napište lambda funkci která určí, jestli je číslo menší než 30




;; 3) Napište lambda funkci která vykreslí DOT na daný Posn v daném Image
(require 2htdp/image)
(define DOT (circle 4 "solid" "red"))
(define BACKGROUND (empty-scene 40 40))




;; 4) Vyzkoušejte přímou aplikaci předchozích lambda funkcí na příslušné hodnoty




;; Výrazům lambda můžeme rozumět jako zkratce pro lokální výraz:
#; (lambda (x) (+ 30 x))
;; můžeme přeložit jako
#; (local ((define (plus-30 x)
             (+ 30 x)))
     plus-30)

;; Přechod od local k lambda funguje vždy, dokud nepotřebujeme použít jméno
;; funkce v těle výrazu (např. při rekurzi) - u lambdy jméno funkce neexistuje!


;; Cvičení
;; 1) Určete které z následujících lambd jsou validní:

#; (lambda (x y) (x y y))

#; (lambda () 20)

#; (lambda (x) x)

#; (lambda (x y) x)

#; (lambda x 10)

;; 2) Pro validní lambdy výše zkuste určit typy hodnot jejich argumentů.




;; 3) Zkuste validní lambdy výše aplikovat na vhodné hodnoty.




;; Definice funkcí které jsme dělali doteď byly "syntax sugar" pro lambdy

(define (function x)
  (+ x 5))

;; je ekvivalentní výrazu

(define fn (lambda (x)
                   (+ x 5)))

;; Definice funkce tedy probíhá ve dvou krocích - vytvoření funkce a pak její
;; pojmenování.

;; Přiřazení jména funkci provádíme ze dvou důvodů - pokud je funkce volána
;; z časteji a z více míst a nechceme všude opakovat ten samý lambda výraz,
;; zároveň z pojmenovaných funkcí se jednoduše tvoří rekurzivní funkce.

;; Lambdy je také vhodné používat spíše jen pro velmi malé funkce.
;; U větších funkcí chceme mít jejich signaturu, účel a testy,
;; aby se s nimi dalo lépe pracovat a byly čitelnější.


;; Cvičení - nejprve vyřešte pomocí local, poté pomocí lambda funkcí

;; 1) Pomocí abstraktní funkce map definujte funkci convert-euro/list, která převede
;;    list CZK na list EUR. Exchange rate je 1 EUR = 25.2 CZK.



;; 2) Stejným způsobem implementujte funkci K->C/list která převede
;;    list hodnot teplot v Kelvinech na teploty v °C




;; 3) Definujte strukturní typ představující záznam v inventáři, který
;;    obsahuje jméno, cenu akvizice (za kolik byl předmět pořízen) a
;;    prodejní cenu (za kolik jej prodáváte dále).
;;    Rozdíl mezi prodejní cenou a cenou akvizice se nazývá marže (margin).
;;    Vytvořte funkci sort-by-margin, která seřadí list záznamů podle
;;    marže (sestupně - od největšího po nejmenší).




;; 4) Pomocí abstraktní funkce ormap definujte funkci contains-name, která z listu
;;    struktur obsahující jméno a věk lidí (takovou strukturu definujte!) a jména
;;    určí, jestli tento list obsahuje člověka s daným jménem.




; ------- REPREZENTACE POMOCÍ LAMBDA -------

;; Sample problem:
;; Námořnictvo reprezentuje lodě jako obdélníky, jejich dosah jako kružnice.
;; Území které pokrývá flotily je kombnací všech kružnic dosahů flotily.
;; 
;; Budeme chtít nadesignovat reprezentace pro obdélníky, kružnice a jejich kombinace.
;; Poté budeme chtít funkci, která určí jestli je nějáký bod uvnitř nějákého tvaru
;; (nebo kombinace tvarů).

;; Zkuste navrhnout reprezentaci flotily nejprve sami.




;; Dále můžeme zkusit "matematický přístup" - tvary budeme definovat pomocí predikátů

; Shape is a function:
;    [Posn -> Boolean]
; If s is Shape and p is Posn, expression (s p)
; determines if p is inside s.


;; Jak bude vypadat definice predikátu inside?

; Shape Posn -> Boolean
(define (inside? shape posn)
  ...)


; Zkusme vyrobit nějáký příklad Shape

; Shape
#; (lambda (p) (and (= (posn-x p) 3) (= (posn-y p) 4)))

; Odpovídá bodu (3, 4)


; Number Number -> Shape
; Constructor of a point
(define (mk-point x y)
  (lambda (p)
    (and (= (posn-x p) x)
         (= (posn-y p) y))))



; Number Number Number -> Shape
; Constructor of a circle (centered in x, y with radius r)
(define (mk-circle x y r)
  (local (; Posn -> Number
          (define (dx pt) (- (posn-x pt) x))
          
          ; Posn -> Number
          (define (dy pt) (- (posn-y pt) y))
          
          ; Posn -> Number
          (define (dist-sqr pt)
            (+ (sqr (dx pt)) (sqr (dy pt)))))
    
    (lambda (pt)
      (<= (dist-sqr pt) (sqr r)))))
            


;; Cvičnení - jak bude vypadat konstruktor obdélníku?

; Number Number Number Number -> Shape
(define (mk-rect upper-left-x upper-left-y width height)
  ...)



; Nyní potřebujeme vytvořit kombinace!

; Shape Shape -> Shape
(define (mk-combination sh1 sh2)
  (lambda (p)
    (or (inside? sh1 p) (inside? sh2 p))))


; Reprezentaci dat pomocí lambd se dále věnuje tzv.
; lambda kalkulus (Alonso Church). Ukazuje, že v jazyce
; s existencí lambd nepotřebujeme lokální definice
; (to neznamená že nejsou užitečné!)