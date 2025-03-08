;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 22-lists-of-lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Listy mohou také obsahovat další listy


; List-of-List-of-String is one of:
; - '()
; - (cons List-of-String List-of-List-of-String)

;; V rámci template se tyto listy nijak neliší
;; od obyčejných listů.

;; Funkce která ale bude konzumovat (first llos)
;; bude muset být také rekurzivní - procházet
;; vnitřní list.

(require 2htdp/batch-io)

(define LINE1 (cons "abc" (cons "def" '())))
(define LINE2 (cons "x" '()))
(define LINE3 (cons "abcd" (cons "def" (cons "x" '()))))

; List-of-String -> Number
; Determines number of words in list of words
(check-expect (count-words '()) 0)
(check-expect (count-words (cons "abc" '())) 1)
(check-expect (count-words (cons "abc" (cons "abc" '()))) 2)
(define (count-words los)
  (cond [(empty? los) 0]
        [(cons? los) (add1 (count-words (rest los)))]))

; List-of-List-of-String -> List-of-Number
; Determines number of strings in each inner list (line).
(check-expect (count-words/line '()) '())
(check-expect (count-words/line
               (cons '()(cons LINE1 (cons LINE2 (cons LINE3 '())))))
              (cons 0 (cons 2 (cons 1 (cons 3 '())))))
(define (count-words/line llos)
  (cond [(empty? llos) '()]
        [(cons? llos) (cons (count-words (first llos))
                            (count-words/line (rest llos)))]))



;; Funkce (list ...)
;; Psaní (cons ... ...) začíná být otravné,
;; spousty "cons" za sebou nejsou příliš
;; čitelné.

;; Nyní přejdeme do jazyka BSL+
;; (Beginning Student Language with List Abbreviations)

;; Listy nyní budeme zavádět pomocí výrazu
#;(list 1 2 3 4 5)
#;(list "abc" "def" "ghi")

;; Tyto listy jsou stále "linked listy",
;; v počítači jsou reprezentovány jako
;; posloupnost indukovaných cons.
;; Máme ale abstrakci, která nám umožní
;; lepší čitelnost a práci s nimi.
