;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 17-interactive-programs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Interaktivní programy
(require 2htdp/image)
(require 2htdp/universe)

;; Interaktivní programy konzumují události
;; (eventy) z OS (interakce s myší,
;; klávesnicí, internetem ...)
;; Reagují na tyto události event handlery
;; (funkcemi, které mění momentální stav programu)


;; V BSL máme knihovnu 2htdp/universe která
;; zajistí přísun eventů a umožňuje
;; vytvářet handlery

;; Handler je funkce, která z momentálního
;; stavu programu a dat eventu vytvoří
;; nový stav
;; --> Chová se podobně jako transition
;; funkce FSM

;; Interaktivní program můžeme považovat
;; za state machine (nemáme zaručenou
;; konečnost stavů!!!)



; Counter is a Number
; Represents current count

;; Data KeyEvent definována v 2htdp/universe

; Counter KeyEvent -> Counter
; Increases the counter on arrow up and decreases on arrow down.
(check-expect (key-handler 0 "up") 1)
(check-expect (key-handler 0 "down") -1)
(check-expect (key-handler 0 "o") 0)
(define (key-handler current key)
  (cond [(key=? key "up") (add1 current)]
        [(key=? key "down") (sub1 current)]
        [else current]))


;; 2htdp/universe nám také umožňuje vykreslit momentální
;; stav do UI (user interface)
(define TEXT-SIZE 36)
(define TEXT-COLOR "indigo")
(define WINDOW-HEIGHT 256)
(define WINDOW-WIDTH 256)

; Counter -> Image
; Creates image with number equal to the value of counter
(define (draw-counter counter)
  (place-image
   (text (number->string counter)
         TEXT-SIZE TEXT-COLOR)
   (/ WINDOW-WIDTH 2) (/ WINDOW-HEIGHT 2)
   (empty-scene WINDOW-WIDTH WINDOW-HEIGHT)))


;; Pro vytvoření interaktivního programu se pak
;; použije výraz (big-bang initial handlers...)
#;(big-bang 0
  [to-draw draw-counter]
  [on-key key-handler])




;; Stav programu může být libovolný typ,
;; musíme ale dodržovat kontrakty.


; TrafficLightState is one of
; - "red"
; - "yellow"
; - "green"
; represents a state on traffic lights


; TimeDelay is a number in the interval of
; - 0 to infinity
; represents delay in ticks


(define RED-DURATION-SECONDS 8)
(define GREEN-DURATION-SECONDS 6)
(define YELLOW-DURATION-SECONDS 2)

(define TICKS-IN-SECOND 28)

; TrafficLightState -> TimeDelay
; Returns the duration of the lights state in ticks
(define (tl-state-duration state)
  (* TICKS-IN-SECOND
     (cond [(string=? state "red") RED-DURATION-SECONDS]
           [(string=? state "yellow") YELLOW-DURATION-SECONDS]
           [(string=? state "green") GREEN-DURATION-SECONDS])))


; TrafficLightState -> TrafficLightState
; Returns next state on the traffic light
(define (transition-tl state)
  (cond [(string=? state "red") "green"]
        [(string=? state "green") "yellow"]
        [(string=? state "yellow") "red"]))


; WorldState is a struct
#;(make-world-state TrafficLightState TimeDelay)
; represents world state of interactive application
; where circle following TrafficLightState finite state
; machine is at located at pos
(define-struct world-state [tl time-remaining])

; TrafficLightState -> WorldState
; initial WorldState for given light state
(define (initial-world-state state)
  (make-world-state state (tl-state-duration state)))

; WorldState -> WorldState
; ticks the world state
(define (tl-tick-handler state)
  (if (= (world-state-time-remaining state) 0)
      (initial-world-state (transition-tl (world-state-tl state)))
      (make-world-state (world-state-tl state)
                        (sub1 (world-state-time-remaining state)))))


(define TL-CIRCLE-RADIUS 64)
(define TL-WINDOW-WIDTH 256)
(define TL-WINDOW-HEIGHT 256)
(define TL-POS (make-posn 128 128))
; WorldState -> Image
; renders world state
(define (tl-draw state)
  (place-image
   (circle TL-CIRCLE-RADIUS "solid" (world-state-tl state))
   (posn-x TL-POS) (posn-y TL-POS)
   (empty-scene TL-WINDOW-WIDTH TL-WINDOW-HEIGHT)))

#;(big-bang (make-world-state "red" 64)
  [on-draw tl-draw]
  [on-tick tl-tick-handler])


;; Cvičení:
; Rozšiřte interaktivní program semaforu o
; možnost stisknout mezerník (space) a
; okamžitě přejít na následující stav.
; Budete muset nejprve napsat vhodný
; handler pro on-key event.




