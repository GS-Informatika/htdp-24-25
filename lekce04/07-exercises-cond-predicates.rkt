;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 07-exercises-cond-predicates) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; -- Opakování - predikáty, if a cond --

; Cvičení 1
; Napište funkci classify-string klasifikující
; textový řetězec následujícím způsobem
; Pokud je string "lower-case" (obsahuje pouze malá písmena),
; funkce vrátí textový řetězec "lowercase".
; Pokud je string "upper-case" (obsahuje pouze velká písmena),
; funkce vrátí textový řetězec "uppercase".
; Pokud string obsahuje pouze číslice (je "numerický"),
; funkce vrátí hodnotu "numeric".
; Ve všech ostatních případech funkce vrátí hodnotu #false
; Predikáty ke klasifikaci stringů hledejte v dokumentaci (F1)





(require 2htdp/image)
; Cvičení 2
; Definujte predikáty image-wide? a image-tall?





; Cvičení 3
; Definujte funkci (inside? image x y) která určí,
; jestli je daný bod uvnitř obrázku.




