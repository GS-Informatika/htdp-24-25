;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 15-structural-types) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Strukturní (kompozitní) typy

;; Informaci jsme reprezentovali pomocí dat

;; Ty jsme definovali pomocí interních typů
;; jazyka BSL

; Centimeter is a Number
; Represents length in cenimeters


;; Doposud jsme se setkali pouze s
;; několika interními typy jazyka:
;; - String
;; - Number
;; - Boolean
;; - Image

;; Pro programování ale potřebujeme reprezentovat složitější data

;; - V počítačové hře:
;;   Pozice hráče, pozice NPC, úkol pro hráče (zadání, průběh a odměna)

;; - V aplikaci adresáře kontaktů:
;;   Reprezentace kontaktu - jméno, adresa, mobilní telefon, pracovní telefon

;; - V aplikaci pro kontrolu inventáře skladu:
;;   ID, jméno a počet momentálně naskladněných kusů, umístění ve skladu


;; Pro reprezentaci složitějších dat používáme struktury:
;; datové typy které mohou obsahovat více hodnot.

;; V BSL máme některé strukturní typy předem definované - například posn - 2D souřadnice
;; 2D Pozice se skládá ze dvou primitivních částí dat - souřadnice x a souřadnice y.

;; Data typu posn vytváříme pomocí konstruktoru make-posn

(define position-1
  (make-posn 3 4))

;; Se strukturními typy pak pracujeme stejně jako s jinými datovými typy, potřebujeme ale
;; přístup k datům schovaným uvnitř - selektory
#;(posn-x position-1)
#;(posn-y position-1)

;; Dále máme predikát, který určuje zda jsou nějáká data strukturní typ posn
#;(posn? position-1)
#;(posn? "not a posn")

;; Dále můžeme se strukturním datovým typem pracovat stejně jako jsme pracovali s jinými daty
;; Příklad - Funkce určující euklidovskou vzdálenost od středu souřadného systému (0, 0)

; Posn -> Number
; Computes distance of pos from (0, 0).
; given (make-posn 0 0), expect 0
; given (make-posn 2 0), expect 2
; given (make-posn 0 2), expect 2
; given (make-posn 3 4), expect 5
(define (distance-from-0 pos)
  (sqrt (+ (sqr (posn-x pos))
           (sqr (posn-y pos)))))


;; Vlastní strukturní typy definujeme pomocí define-struct.
;; Definice posn vypadá následovně:
#;(define-struct posn [x y])

;; Obecně je definice strukturního typu následující
#;(define-struct JménoStrukturníhoTypu [JménoPole ...])

;; Data obsažená ve strukturním typu jsou uložena v tzv. polích.
;; V případě posn máme pole x a pole y.

;; Hodnoty tohoto typu vytváříme pomocí
#;(make-JménoStrukturníhoTypu HodnotaPole ...)


;; Definice strukturního typu pro záznam člověka

; Person is a struct
#;(make-person String String Number String)
; Record of a person.
(define-struct person [first-name surname year-born nationality])

;; Všimněte si, že definice strukturního typu je
;; doprovázena definicí dat.

;; Syntax define-struct zajistí definici konstruktoru
;; pro náš strukturní typ
(define CLINT-EASTWOOD
  (make-person "Clint" "Eastwood" 1930 "USA"))

(define DANNY-BOYLE
  (make-person "Danny" "Boyle" 1956 "England"))


;; ----- CVIČENÍ -----

; 1) Definujte strukturní typ posn-3D
;; který bude mít pole x, y, z.
;; Vytvořte alespoň 2 hodnoty tohoto typu.




;; ----- ------- -----

;; Strukturní typ může obsahovat ve svých polích další strukturní typy

;; Definice strukturního typu pro databázi filmů

; Movie is a struct
#;(make-movie String Person Number)
; Record of a movie in movie database.
(define-struct movie [title director year])


(define GRAN-TORINO
  (make-movie "Gran Torino" CLINT-EASTWOOD 2008))

(define TRAINSPOTTING
  (make-movie "Trainspotting" DANNY-BOYLE 1996))


;; Dále define-struct zajistí selektory pro jednotlivá pole
#;(person-surname DANNY-BOYLE)
#;(person-year-born CLINT-EASTWOOD)

#;(movie-title TRAINSPOTTING)
#;(person-surname (movie-director GRAN-TORINO))

;; Obecně má selektor syntax
#;(JménoStruktury-JménoPole HodnotaStruktury) ; = HodnotaPole

; Movie -> String
; Creates a info text about given movie m.
; given (make-movie "A" (make-person "N" "S" 1970 "X") 1990),
; expect "A, N S, 1990"
(define (movie-info m)
  (string-append
   (movie-title m) ", "
   (person-first-name (movie-director m)) " "
   (person-surname (movie-director m)) ", "
   (number->string (movie-year m))))

#; (movie-info GRAN-TORINO)

;; Syntax define-struct také vytvoří predikát
;; pro náš strukturní datový typ
#;(movie? GRAN-TORINO)
#;(movie? CLINT-EASTWOOD)
#;(person? CLINT-EASTWOOD)


;; --- CVIČENÍ ---

;; 1)Určete na jakou hodnotu se redukuje výraz
#;(person-nationality
   (movie-director
    (make-movie "Seven Samurai"
                (make-person "Akira" "Kurosawa"
                             1910 "Japan")
                1954)))




;; 2) Definujme následující struktury (nyní bez
;; datových typů)
(define-struct song [title artist year])

(define-struct blood-donor
  [name blood-type last-donation phone])

(define-struct pet [name number])

(define-struct CD [artist title price])

(define-struct sweater [material size producer])
;; Napište jména funkcí (konstruktorů,
;; predikátů, selektorů) které tyto definice
;; zavádí.




;; -- ------- ---


;; Template pro strukturní typy

;; Pro každou hodnotu strukturního typu
;; do template připravíme aplikaci selektorů.
;; Ne všechny selektory pak musíme nutně využít!

; Player is a struct
#; (make-player String Number)
; A record of chess player.
(define-struct player [username rank])

; Player Player -> Boolean
; Checks if p1 has higher rank than p2
; given (make-player "X" 21) (make-player "Y" 20), expect true
; given (make-player "X" 20) (make-player "Y" 21), expect false
; given (make-player "X" 20) (make-player "Y" 20), expect false
(define (player>? p1 p2)
  (... (player-username p1) ...
       (player-rank p1) ...
       (player-username p2) ...
       (player-rank p1) ...))


;; Cvičení
;; Vytvořte templaty pro strukturní typy
;; zavedené výše - song, blood-donor, pet, CD, sweater.



