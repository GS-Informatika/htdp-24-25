;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04-functions-exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Funkce a jejich kompozice
;; --- CVIČENÍ ---
(require 2htdp/image)

; 1) Definujte funkci
#; image-area
;; která určí počet pixelů v obrázku.

;; Hint: Použíjte dokumentaci - vyhledejte
;; funkce které poskytuje modul
#; 2htdp/image





; 2) Definujte funkci
#; string-first
;; která ze stringu vyextrahuje první znak.

;; Hint:
;; V dokumentaci (F1) naleznete funkce které
;; pracují se stringy. Najděte funkci
;; která umí vyextrahovat i-tý znak.





; 3) Definujte funkci
#; string-insert
;; která konzumuje číslo i a 2 stringy,
;; a vrátí string, kde je za i-tým znakem
;; prnvího stringu vložený druhý string.
;; Ukázky použití:
#; (string-insert 1 "abc" "_") ; = "a_bc"
#; (string-insert 2 "abc" "++") ; = "ab++c"

;; Hint:
;; Opět hledejte v dokumentaci - bude potřeba
;;  použít funkci, která umí vytvářet substringy.





; 4) Definujte funkci
#; string-delete
;; která konzumuje číslo i a string a vrátí
;; string, kde chybí i-tý znak.





; 5) Prozkoumejte chování jazyka BSL:
;; Definujeme funkci
(define (ff x)
  (* 10 x))
;; Použíjte tlačítko Step (stepper) pro
;; vyhodnocení výrazů
#; (ff 1)
#; (ff (ff 1))
#; (+ (ff 1) (ff 1))
;; Jaké výrazy se ve složeném výrazu musí
;; vyhodnotit jako první?
;; Používá BSL výsledky předchozích výpočtů?




