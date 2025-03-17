;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 24-abstraction-of-functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ------------------- ABSTRAKCE -------------------

;; Spousta funkcí, se kterými jsme se setkali, vypadá velmi podobně.
;; Při rekurzi vypadala většina funkcí téměř stejně, lišily se jen v
;; hodnotě pro base case a ve vyhodnocení rekurzivního kroku.

;; Tyto podobnosti jsou ale problematické - v kódu běžně vedou na repetici,
;; programátor zkopíruje existující kód a případně jej lehce upraví pro
;; požadovaný účel. Kopírování kódu sebou nese velký problém - kopírují se chyby!


(define-struct person [first-name age])
; Person is a struct
#;(make-person String Number)


; List-of-Person is one of:
; - '()
; - (cons Person List-Of-Person)


;; Jaký je rozdíl mezi následujícími funkcemi?


; List-of-Person -> Number
; Determines number of people named "James".
(check-expect (count-james (list (make-person "James" 30))) 1)
(check-expect (count-james (list (make-person "John" 30))) 0)
(define (count-james lop)
  (cond [(empty? lop) 0]
        [(cons? lop)
         (if (string=? (person-first-name (first lop)) "James")
             (add1 (count-james (rest lop)))
             (count-james (rest lop)))]))


; List-of-Person -> Number
; Determines number of people named "Amy".
(check-expect (count-amy (list (make-person "Amy" 30))) 1)
(check-expect (count-amy (list (make-person "James" 30))) 0)
(define (count-amy lop)
  (cond [(empty? lop) 0]
        [(cons? lop)
         (if (string=? (person-first-name (first lop)) "Amy")
             (add1 (count-amy (rest lop)))
             (count-amy (rest lop)))]))


; List-of-Person -> Number
; Determines number of people named "John".
(check-expect (count-john (list (make-person "John" 30))) 1)
(check-expect (count-john (list (make-person "James" 30))) 0)
(define (count-john lop)
  (cond [(empty? lop) 0]
        [(cons? lop)
         (if (string=? (person-first-name (first lop)) "John")
             (add1 (count-john (rest lop)))
             (count-john (rest lop)))]))


;; Kopírovaný kód se také hůře přizpůsobuje změnám požadavků
;; Jak bychom museli upravit předchozí funkce, pokud by se upravil požadavek
;; na započítávání lidí - přidání pole pro příjmení a započtení podle
;; křestního jména i příjmená?


;; Programátoři se snaží redukovat podobnosti v kódu.
;; Nejprve si tedy děláme "draft" programu, ve kterém se
;; snažíme najít podobnosti a následně draft upravit tak, abychom se jich
;; zbavili. Toho dosáhneme pomocí abstrakce.


;; Abstrakce funkcí pro počet lidí

; Person String -> Boolean
; Checks if the person has name as first name
(define (is-named? person name)
  (string=? (person-first-name person) name))


; List-of-Person String -> Number
(define (named-person-count lop name)
  (cond [(empty? lop) 0]
        [(cons? lop) (if (is-named? (first lop) name)
                         (add1 (named-person-count (rest lop) name))
                         (named-person-count (rest lop) name))]))

;; Původní funkce jsou pak specializace abstrahované funkce

; List-of-Person -> Number
(define (count-amy.v2 lop)
  (named-person-count lop "Amy"))


; List-of-Person -> Number
(define (count-james.v2 lop)
  (named-person-count lop "James"))


;; Cvičení:
;;   Zkuste vymyslet jak provést abstrakci následujících funkcí?

; List-of-String -> Boolean
; Checks if list contains string with exactly 10 letters

(define (contains-10-letter-string? l)
  (cond [(empty? l) #f]
        [(cons? l) (if (= (string-length (first l)) 10)
                       #t
                       (contains-10-letter-string? (rest l)))]))

; List-of-String -> Boolean
; Checks if list contains string with exactly 10 letters
(define (contains-8-letter-string? l)
  (cond [(empty? l) #f]
        [(cons? l) (if (= (string-length (first l)) 8)
                       #t
                       (contains-8-letter-string? (rest l)))]))







;; Abstrakci je vhodné provádět pouze na místech, která
;; spolu souvisí (typicky konzumují úplně stejný datový typ).
;; Pokud provádíme abstrakci pouze na základě podobnosti
;; kódu, může se stát, že při změně požadavků na kód
;; nebude jedna z více specializací dále kompatibilní s
;; abstrakcí a naopak si přiděláme práci.

;; Není také vhodné snažit se vytvořit příliš obecné abstrakce.
;; Vznikají pak funkce s mnoha parametry, které je
;; těžké používat, upravovat i chápat.

;; Abstrakce provádějte až v rámci pozdější iterace
;; psaní kódu. Vymyslet správnou abstrakci
;; "na první pokus" se typicky nepovede.
