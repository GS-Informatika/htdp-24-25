;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-booleans) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
(define value1 #true)
(define value2 #true)

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


;; Booleany využíváme při rozhodování - větvení kódu (branching)
;; Výraz if - podmíněný výraz

(define sunny #true)
(define accessory
  (if sunny
      "sunglasses" ; Pokud je sunny #true výraz (if ...) se vyhodnotí na "sunglasses"
      "umbrella")) ; Pokud je sunny #false výraz (if ...) se vyhodnotí na "umbrella"

;; Výraz if má obecně zápis
#;(if VýrazBool VýrazTrue VýrazFalse)

(define warm-treshold-celsius 39)
(define (water-status temperature-celsius)
  (if (>= temperature-celsius warm-treshold-celsius)
      "warm"
      "not warm"))

;; Občas potřebujeme porovnat více možností - vnořování if výrazů není příliš přehledné!
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

(require 2htdp/image)
(require 2htdp/universe)
;; V minulých lekcích jsme si ukázali funkci
#;(animate ...)

;; Animovali jsme volný pád tečky - funkce generující:
#;(define (picture-of-dot param)
  (place-image (circle 5 "solid" "red")
               50 (sqr param)
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
