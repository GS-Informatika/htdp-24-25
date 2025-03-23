;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 29-local-scope) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ------- LOKÁLNÍ DEFINICE -------

;; Některé funkce závisí na hodnotách nebo
;; jiných funkcích, které mají smysl
;; pouze v užším kontextu


; PersonAddress is a struct
#;(make-address String String String)
; Represents an association of person to an address
(define-struct address [first-name last-name street])

; [List-of PersonAddress] -> String
; Creates a string with all person names sorted by name of person
(define (names l)
  (foldr string-append-with-space ""
         (map person-name
              (sort l name<?))))


; String String -> String
; Concatenates two strings with a space between them
(define (string-append-with-space s t)
  (string-append " " s t))


; PersonAddress PersonAddress -> Boolean
; Determines order of two person addresses based on surname and first name
(define (name<? addr1 addr2)
  (string<? (string-append (address-last-name addr1)
                           (address-first-name addr1))
            (string-append (address-last-name addr2)
                           (address-first-name addr2))))


; PersonAddress -> String
; Creates representation of person from address ("Name Surname")
(define (person-name addr)
  (string-append "[" (address-first-name addr) " " (address-last-name addr) "]"))


(define example0
  (list (make-address "Rose" "Hauser" "Washingtonova")
        (make-address "Dakota" "Mohr" "Barrandovská")
        (make-address "Wesley" "Adler" "Argentinská")
        (make-address "Caiden" "Liu" "Dělnická")
        (make-address "Robyn" "Cobb" "Jankovcova")))

#; (names example0)


;; Funkce name<? a string-append-with-space zřejmě nebudou mít význam mimo
;; použití ve funkci names.
;; ISL nám dává nástroj pro vyjádření takové hierarchie.
;; Tomuto nástroji se říká lokální definice, případně privátní definice

;; V ISL má lokální definice následující tvar

; [List-of PersonAddress] -> String
(define (names.v2 l)
  (local (
          ; PersonAddress PersonAddress -> Boolean
          ; Determines lexicographical ordering of two PersonAddresses based on surname and first name
          (define (name<? addr1 addr2)
            (string<? (string-append (address-last-name addr1) (address-first-name addr1))
                      (string-append (address-last-name addr2) (address-first-name addr2))))
          
          ; PersonAddress -> String
          ; Creates representation of person from address ("Name Surname")
          (define (person-name addr)
            (string-append "[" (address-first-name addr) " " (address-last-name addr) "]"))
          
          ; String String -> String
          ; Concatenates two strings with a space between them
          (define (helper s t)
            (string-append " " s t))
          
          ; 1. Seřazení adres podle jmen
          ; [List-of PersonAddress]
          (define sorted (sort l name<?))
          ; 2. Extrakce jmen
          ; [List-of String]
          (define names (map person-name sorted)))
    
    (foldr helper "" names)))

#; (names.v2 example0)

;; Lokálně definovanou hodnotu můžeme použít pouze uvnitř bloku local

#; (local (
        (define x 5)
        (define y (+ x 5))
        )
  (+ x y))


;; Lokální definice "stíní" nadřazené definice
(define x 5)
#; (local ((define x 10))
  (local ((define x 20))
    x))


;; Lokální definice nám také umožňují snížit zanoření výrazů - můžeme
;; postupně vytvářet mezihodnoty!
;; To nám také umožňuje snížit časovou komplexitu - některé výpočty nemusíme
;; provádět vicekrát!


; [T]: [T T -> Boolean] [NE-List-of T] -> T
(define (slow-pick-one op list)
  (cond [(empty? (rest list)) (first list)]
        [else (if (op (first list) (slow-pick-one op (rest list)))
                  (first list)
                  (slow-pick-one op (rest list)))]))


; [T]: [T T -> Boolean] [NE-List-of T] -> T
(define (fast-pick-one op list)
  (cond [(empty? (rest list)) (first list)]
        [else (local ((define picked (fast-pick-one op (rest list))))
                (if (op (first list) picked)
                    (first list)
                    picked))]))


(define test-list '(5 8 7 1 6 8 7 6 3 41 9 4 1 32 8 4  12 56 32 12 8 10 9 1 6 16))
#; (slow-pick-one > test-list)
#; (fast-pick-one > test-list)


;; ------ Cvičení ------

(define WINDOW-WIDTH 100)
(define WINDOW-HEIGHT 100)

;; Navrhněte funkci filter-inside která z listu Posn vybere všechny Posn,
;; které jsou uvnitř okna o šířce WINDOW-WIDTH a výšce WIDNOW-HEIGHT
;; (jsou v intervalu mezi 0 a délkou/šířkou). Využíjte design recipe,
;; vestavěné abstrakce a lokální definici pro vhodný predikát




; ----------------------



;; ------ Cvičení ------

;; Navrhněte funkci in-range? která z listu hodnot Posn určí
;; jestli je některý Posn z listu "blízko" zadané pozici pt.
;; Blízko znamená že se nachází maximálně v euklidovské vzdálenosti
;; dané proměnnou range od zadaného bodu.
;; Použíjte design recipe, vestavěné abstrakce a lokální definice




; ----------------------


;; Lokální definice nám také umožňují vytvářet funkce!
;; Ukázka - vytvoření predikátu z dat

(require 2htdp/image)

(define-struct circleS (center radius color))
; Circle is a struct
#; (make-circleS Posn Number Color)


; Circle Image -> Image
; Adds a circle c to image
(define (place-circle c image)
  (place-image (circle (circleS-radius c) 'outline (circleS-color c))
               (posn-x (circleS-center c)) (posn-y (circleS-center c))
               image))


; Posn Image -> Image
; Adds a dot to image on posn p
(define (place-dot p image)
  (place-image (circle 2 'solid 'red)
               (posn-x p) (posn-y p)
               image))


; Posn Number -> (Posn -> Boolean)
(define (mk-is-inside-circle circle)
  (local (; Posn Posn -> Number
          ; Determines square of euclidean distance from posn1 to posn2
          (define (distance-sqr posn1 posn2)
            (+ (sqr (- (posn-x posn1) (posn-x posn2)))
               (sqr (- (posn-y posn1) (posn-y posn2)))))
          ; Posn -> Boolean
          ; Determines if distance of posn from circle center is less than radius
          (define (pred posn)
            (> (sqr (circleS-radius circle)) (distance-sqr (circleS-center circle) posn))))
    pred))


(define circle1 (make-circleS (make-posn 50 50) 30 "red"))
(define circle2 (make-circleS (make-posn 50 60) 38 "blue"))
(define circle3 (make-circleS (make-posn 40 30) 24 "green"))

(define p1 (make-posn 23 25))
(define p2 (make-posn 31 40))

; Image
(define IMG (foldl place-circle
                   (empty-scene 120 120)
                   (list circle1 circle2 circle3)))

; Image
(define WITH-DOTS (foldl place-dot IMG (list p1 p2)))

; Posn -> Boolean
(define in-circle1? (mk-is-inside-circle circle1))

; Posn -> Boolean
(define in-circle2? (mk-is-inside-circle circle2))

#; WITH-DOTS
#; (in-circle1? p1)
#; (in-circle2? p1)
#; ((mk-is-inside-circle circle3) p1)

;; Takto vytvořeným funkcím se také říká "closure".
;; Uzavírají hodnoty proměnných předané z vnější funkce.
