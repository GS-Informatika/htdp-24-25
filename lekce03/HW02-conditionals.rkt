;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HW02-conditionals) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
; Na předchozích lekcích jsme animovali volný pád tečky
; pomocí následující funkce:
(define (picture-of-dot param)
  (place-image (circle 5 "solid" "red")
               50 (sqr param)
               (empty-scene 100 300)))

; Vaším úkolem je vytvořit podobnou animaci,
; odehrávající se na plátně o šířce WIDTH
; a výšce HEIGHT s kroužkem CIRCLE.
; Kroužek začne na výchozí pozici x = WIDTH / 2, y = 0 a bude padat podle
; vzorce y(time) = 0.1 * time * time.

; Jakmile se ale kroužek dotkne spodního okraje scény,
; zastaví se a nebude se dále pohybovat.

; Doplňte funkci circle-height (která určuje souřadnici y v animaci).

(require 2htdp/image)
(define WIDTH 100)
(define HEIGHT 300)
(define CIRCLE (circle 5 "solid" "red" ))
(define SCENE (empty-scene WIDTH HEIGHT))

(define (circle-height time)
  ...)

(define (falling-dot-picture time)
  (place-image
   CIRCLE
   (/ WIDTH 2)
   (circle-height time)
   SCENE))

#;(animate falling-dot-picture)
