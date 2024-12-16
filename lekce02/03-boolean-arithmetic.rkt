;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-boolean-arithmetic) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ukazovali jsme si aritmetiku následujících typů
;; - Number
;; - String
;; - Image


;; Nyní se podíváme na datový typ Boolean
#;#true
#;#false

;; S Booleany jsme se již setkali ve funkci
#;(string->number "non-numeric string")
;; která vrátí
#; #false
;; pro argumenty které nelze převést


;; Operace s booleany

;; Unární operace - 1 argument

;; not - převrací hodnotu argumentu
#;(not #true) #;#false


;; Binární operace - 2 argumenty
(define left #true)
(define right #true)

;; or - #true pokud alespoň 1 argument je #true
#;(or left right)

;; and - #true pokud všechny argumenty jsou #true
#;(and left right)

;; (or ...) a (and ...) jsou short-circuit operace
;; (podléhají zkrácenému vyhodnocování - McCarthy evaluation).
;; Vyhodnotí se pouze tolik výrazů, kolik je potřeba na
;; určení výsledku.

;; To je velmi podstatné pro tzv. vedlejší efekty.
#;(and #false (error "no"))

;; V imperativních jazycích se řeší pomocí sekvenčních bodů.



;; Booleany lze získat operacemi na jiných datových typech,
;; například porovnáváním čísel
#;(< 1 2) #;#true
#;(< 5 1) #;#false
#;(= 4 4) #;#true
#;(>= 10 5) #;true
#;(>= 5 5) #;true
#;(>= 4 5) #;false
