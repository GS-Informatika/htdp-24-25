;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 20-natural-numbers-induction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Rekurzivní datové typy se neváží jen k seznamům.
;; podobnou strukturu jako listy mohou mít přirozená čísla.

; Nat is one of
; - 0
; - (add1 Nat)

;; Této definici se říká Peanova konstrukce.
;; Číslu (add1 _) se říká "následovník"
;; (successor - succ(x))

;; Funkce add1 slouží jako konstruktor nových
;; dat (stejně jako cons u listů)

;; Diskuze - Co je selektor
;; rekurzivních dat? (obdoba rest u listu)


;; Pro sčítání Peanových čísel platí 
;; a + 0 = a
;; a + succ(x) = succ(a + x) ==> a + succ(x) = succ(a) + x

;; Nyní napíšeme funkci pro součet podle předpisu na levé straně implikace

; Nat Nat -> Nat
; Sums two Nats
(define (nat-add a b)
  ...)


;; A pomocí předpisu na pravé straně implikace
(define (nat-add2 a b)
  ...)

;; Vyhodnoťme následující výrazy pomocí stepperu a porovnejme

#;(nat-add 3 5)
#;(nat-add2 3 5)

;; nat-add2 má lepší prostorovou složitost - konstantní
;; Diskuze - proč?

;; Druh rekurze s konstantní prostorovou složitostí je velmi důležitý
;; Říká se mu "tail call rekurze" a některé překladače tento typ rekurze umí
;; velmi dobře optimalizovat (včetně používaných překladačů jazyka C).
;; Tail rekurze je ekvivalentní "for cyklu".
