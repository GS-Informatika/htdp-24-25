;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 30-closures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Lokální definice nám také umožňují vytvořit
;; funkci jako výsledek evaluace jiné funkce.

;; Příklady: vytváření predikátů
;;  na základě dat

;; 1) Predikát na délku stringu

; Number -> (String -> Boolean)
; Creates a predicate testing if the string
; has length n
(define (has-length? n)
  (local (; String -> Boolean
          (define (predicate s)
            (= (string-length s) n)))
    predicate))

(define has-length-2? (has-length? 2))
#;(has-length-2? "ab")



;; 2) Predikát jestli se bod nachází
;;    uvnitř specifikované kružnice

(require 2htdp/image)

(define-struct circleS (center radius color))
; Circle is a struct
#; (make-circleS Posn Number Color)


; Circle Image -> Image
; Adds a circle c to image
(define (place-circle c image)
  (place-image (circle (circleS-radius c) "outline" (circleS-color c))
               (posn-x (circleS-center c)) (posn-y (circleS-center c))
               image))


; Posn Image -> Image
; Adds a dot to image on posn p
(define (place-dot p image)
  (place-image (circle 2 "solid" "red")
               (posn-x p) (posn-y p)
               image))


; CircleS -> (Posn -> Boolean)
(define (mk-is-inside-circle circle)
  (local (; Posn Posn -> Number
          ; Determines square of euclidean distance from posn to center of circle
          (define circle-center (circleS-center circle))
          (define (distance-center-sqr posn)
            (+ (sqr (- (posn-x posn) (posn-x circle-center)))
               (sqr (- (posn-y posn) (posn-y circle-center)))))
          ; Posn -> Boolean
          ; Determines if distance of posn from circle center is less than radius
          (define (pred posn)
            (> (sqr (circleS-radius circle)) (distance-center-sqr posn))))
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

;; Takto vytvořeným funkcím se také říká "closure".
;; Uzavírají hodnoty proměnných předané z vnější funkce.


;; PROCVIČOVÁNÍ

;; 1) Napište funkci, která vytvoří predikát
;;    určující jestli je čístlo mezi hodnotami
;;    start a end




;; 2) Napište funkci make-square-generator,
;;    která konzumuje číslo n a vytvoří funkci
;;    konzumující barvu (String) a produkující
;;    Image čtverce o straně n s danou barvou



