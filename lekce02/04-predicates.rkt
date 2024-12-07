;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04-predicates) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Predikáty

;; Výraz
#;(string->number "abc")
;; nám vrátil indikátor, že data nejsou vhodná pro tuto operaci.

;; V některých případech ale tento indikátor nedostaneme, místo toho
;; program signalizuje chybu (error) a aplikace "spadne".
;; Výraz který signalizuje chybu pak nemá výsledek, nelze redukovat!
#;(string-length 1)

;; Než tedy aplikujeme funkci na data, měli bychom si být jisti, že data
;; mají správný formát - splňují tzv. pre-conditions.

;; Predikáty jsou funkce vracející boolean, který značí jestli hodnota
;; splňuje nějakou podmínku.

;; Lze jimi například ověřit datový typ:
#;(number? 4)
#;(number? "pi")
#;(string? "pi")
#;(boolean? #false)


;; Nebo užší klasifikaci dat:
#;(odd? 4)
#;(even? 4)
#;(rational? pi) ;(Dokážete říct, proč je výsledek #true? π není racionální!)
#;(false? #false)

;; Predikáty si můžeme sami definovat - dle potřeb domény
;; Nazvěmě String "dlouhý" pokud má více než 20 znaků
(define (is-long? some-string)
  (> (string-length some-string) 20))
#;(is-long? "abcd")
#;(is-long? "abcdefghijklmnopqrstuvwxyz")

;; Predikáty vracejí boolean - můžeme je tedy přímo využívat pro větvení kódu!
(define (to-short-message message)
  (if (is-long? message)
      "Message to long!"
      message))
