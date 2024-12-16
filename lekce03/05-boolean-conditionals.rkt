;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05-boolean-conditionals) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Booleany využíváme při rozhodování - větvení kódu (branching)
;; Výraz if - podmíněný výraz

(define SUNNY #true)
(define ACCESSORY
  (if SUNNY
      "sunglasses" ; Pokud je sunny #true ->
      ;; výraz (if ...) se vyhodnotí na "sunglasses"
      "umbrella")) ; Pokud je sunny #false ->
      ;; výraz (if ...) se vyhodnotí na "umbrella"

;; Výraz if má obecně zápis
#;(if VýrazBool VýrazTrue VýrazFalse)

(define warm-treshold-celsius 39)
(define (water-status temperature-celsius)
  (if (>= temperature-celsius warm-treshold-celsius)
      "warm"
      "not warm"))


;; --- CVIČENÍ ---
; Pracujeme s obrázky - potřebujeme modul
(require 2htdp/image)

;  Definujte funkci
#; image-classify
;; která zkonzumuje obrázek a vytvoří
;;  - string "tall" pokud je výška obrázku větší
;;    než šířka obrázku
;;  - string "wide" pokud je šířka obrázku větší
;;    než výška obrázku
;;  - string "square" pokud je šířka obrázku
;;    stejná jako výška obrázku.




  
;; Vnořování if výrazů není příliš přehledné.
(define (signum-bad x)
  (if (> x 0)
      1
      (if (= x 0)
          0
          -1)))

;; Lepší je využít "cond" klauzuli - kondicionál
(define (signum x)
  (cond [(> x 0) 1]
        [(= x 0) 0]
        [(< x 0) -1]))

;; Kondicionál má tvar
#;(cond
    [VýrazPodmínky1 VýslednýVýraz1]
    [VýrazPodmínky2 VýslednýVýraz2]
    ...
    [VýrazPodmínkyN VýslednýVýrazN])

#; VýrazPodmínkyX ; se vždy redukuje na boolean!

;; --- CVIČENÍ ---

;  Definujte funkci
#; image-classify.v2
;; (z předchozího cvičení) pomocí klauzule cond.





; Pracujeme s animací - potřebujeme modul
(require 2htdp/universe)
;; V minulých lekcích jsme si ukázali funkci
#;(animate ...)

;; Animovali jsme volný pád tečky - funkce generující:
#;(define (picture-of-dot time)
  (place-image (circle 5 "solid" "red")
               50 (sqr time)
               (empty-scene 100 300)))

;; Vaším úkolem bude vytvořit stejnou animaci, odehrávající se na plátně o šířce WIDTH
;; a výšce HEIGHT s kroužkem o poloměru CIRCLE-RADIUS.
;; Jakmile se kroužek dotkne spodního okraje scény zastaví se - nebude se dále pohybovat.
(define WIDTH 100)
(define HEIGHT 300)
(define CIRCLE-RADIUS 3)
(define dot (circle 5 "solid" "red"))

(define (circle-fall t)
  (place-image
   dot
   ...
   (empty-scene ...)))



#;(animate circle-fall)

;; Nápověda: Rozdělte problém na více funkcí - definujte si funkci
#;(circle-height t)
;; která vrátí výšku ve které se má tečka nacházet v čase t.
;; Uvnitř této funkce použíjte výraz if nebo kondicionál cond.
