;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09-function-signatures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Rozšiřme naše datové typy o teploty v různých
;; reprezentacích - Celsius, Fahrenheit a Kelvin.


; TemperatureCelsius is a Number
; Represents temperature in degrees Celsius.


; TemperatureFahrenheit is a Number
; Represents temperature in degrees Fahrenheit.


; TemperatureKelvin is a Number
; Represents temperature in Kelvin.


;; Zaveďme funkce, které převádí mezi jednotlivými
;; reprezentacemi

(define ABSOLUTE-ZERO-CELSIUS 273.15)

; TemperatureCelsius -> TemperatureKelvin
(define (C->K celsius)
  (+ celsius ABSOLUTE-ZERO-CELSIUS))

; TemperatureKelvin -> TemperatureCelsius
(define (K->C kelvin)
  (- kelvin ABSOLUTE-ZERO-CELSIUS))

; TemperatureCelsius -> TemperatureFahrenheit
(define (C->F celsius)
  (+ 32 (* 9/5 celsius)))

; TemperatureFahrenheit -> TemperatureCelsius
(define (F->C farenheit)
  (* 5/9 (- farenheit 32)))


; TemperatureKelvin -> TemperatureFahrenheit
(define (K->F kelvin)
  (C->F (K->C kelvin)))

; TemperatureFahrenheit -> TemperatureKelvin
(define (F->K farenheit)
  (C->K (F->C farenheit)))

;; Poslední dvě funkce využívají kompozici.

;; Zkusme určit jaké datové typy vstupují do funkcí
;; a jaké datové typy mají výsledky.


;; Poslední dvě funkce (K->F a F->K) využívají
;; toho, že vnitřní funkce v kompozici produkuje
;; datový typ, který konzumuje vnější funkce.

;; K->F => K -> C -> F
;; F->K => F -> C -> K

;; Informaci o konzumovaných a produkovaných typech
;; můžeme do kódu zapsat. Tím deklarujeme kontrakt
;; jak funkci používat a co od funkce očekávat.
;; Jiní programátoři pak mohou na základě tohoto
;; kontraktu používat funkci na vhodných místech.
;; V některých jazycích je dokonce zápis konzumovaných
;; a produkovaných datových typů vyžadován.

;; Této informaci o funkci se říká signatura.

;; Funkce z jednoho stringu vytvoří číslo
; String -> Number
(define (string->number/or0 s)
  (if (string-numeric? s)
      (string->number s)
      0))


;; Funkce z jednoho čísla vytvoří boolean
; Number -> Boolean
(define (divisible-by-10? n)
  (= (modulo n 10) 0))


;; Funkce z jednoho stringu a jednoho čísla
;; vytvoří boolean
; String Number -> Boolean
(define (nth-letter-digit? s n)
  (string-numeric? (string-ith s n)))


;; V signaturách samozřejmě můžeme používat
;; i námi definované datové typy

; Centimeter is a Number
; Represents length in cenimeters

; Meter is a Number
; Represents length in meters


;; Převodní funkce pak budou mít signatury

; Centimeter -> Meter
(define (cm->m cm)
  (/ cm 100))



; Meter -> Centimeter
(define (m->cm m)
  (* m 100))


;; ----- Cvičení -----
; 1) Dopište signatury k převodním funkcím
; mezi jednotlivými reprezentacemi teploty
; (Kelvin, Fahrenheit, Celsius) výše.




; 2) Určete, co konzumuje a co produkuje
; funkce, se signaturou

; Number String Image -> Image

