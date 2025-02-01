;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 16-automated-testing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Testování

;; Zkoušení našeho kódu se stává
;; velmi otravným - pro každou funkci
;; ručně ověřujeme několik hodnot,
;; při každé změně kódu bychom idelálně
;; měli otestovat všechny již existující
;; funkce, jestli je naše změny nerozbily.

;; Na místo ukázek použití tedy začneme
;; zapisovat automatické testy


(define ABSOLUTE-ZERO -273.15)

; TemperatureCelsius -> TemperatureKelvin
; Converts Celsius temperatures to Kelvin temperatures.
; given ABSOLUTE-ZERO, expect 0
; given 0, expect 273.15
(define (C->K c)
  (- c ABSOLUTE-ZERO))

;; Ukázky použití nahradíme za výrazy
(check-expect (C->K ABSOLUTE-ZERO) 0)
(check-expect (C->K 0) 273.15)

;; Tato funkce testuje, že výraz v prvním
;; argumentu je totožný výrazu v druhém argumetnu.

#; (check-expect TestovanýVýraz OčekávanýVýraz)

;; Testy můžeme psát přímo na místo ukázek použití
; TemperatureKelvin -> TemperatureCelsius
; Converts Kelvin temperatures to Celsius temperatures.
(check-expect (K->C 0) ABSOLUTE-ZERO)
(check-expect (K->C 273.15) 0)
(define (K->C k)
  (+ k ABSOLUTE-ZERO))


;; Cvičení 1)

; Nadesignujte funkci string-rest, která
; ze stringu odstraní první znak.
; Využíjte design recipe. Místo ukázek
; použití napište vhodné testy.




;; Ne vždy jsme schopni určit přesnou očekávanou
;; hodnotu. Typicky se tento problém vyskytne při
;; práci s neurčitými čísly, kde problém řešíme
;; testováním vůči očekávané hodnotě + povolené
;; chybě

; Posn -> Number
; Computes euclidean distance of p from origin.
#;(check-expect (distance-from-origin (make-posn 6 7))
                (sqrt 85)) ;; fails
(check-within (distance-from-origin (make-posn 6 7))
              (sqrt 85) 0.001)
(define (distance-from-origin p)
  (sqrt (+ (sqr (posn-x p)) (sqr (posn-y p)))))

;; Syntax je
#;(check-within TestovanýVýraz OčekávanýVýraz PovolenáChyba)

;; Povolená chyba se aplikuje na každé neexaktní číslo
;; které se v testovaném výrazu objeví

(check-within (make-posn #i0.1 #i-0.18)
              (make-posn 0 0)
              0.2)

;; Obdobně můžeme testovat místo povolené chyby
;; interval ve kterém očekáváme že se výsledek bude
;; nacházet
(check-range 0.6 0 1)

;; V programech také často pracujeme s náhodně
;; generovanými čísly. Testování funkcí kde se
;; toto generování vyskytuje, vyžaduje schopnost
;; "zopakovat" vygenerované hodnoty ve výrazu
;; očekávaného výsledku

; Posn -> Posn
; Adds random noise (up to max-noise) to Posn value p.
(check-random (jitter-posn 2 (make-posn 0 0))
              (make-posn (random 2) (random 2)))
(define (jitter-posn max-noise p)
  (make-posn (+ (posn-x p)
                (random max-noise))
             (+ (posn-y p)
                (random max-noise))))


;; Pokud naše funkce může ukončit běh programu
;; errorem, chceme testovat i toto chování.

; MaybeNumber -> Number
; Checks if value is number, errors if not.
(check-random (unwrap-number (random 100)) (random 100))
(check-error (unwrap-number #false))
(define (unwrap-number mn)
  (if (number? mn)
      mn
      (error "not a number")))
