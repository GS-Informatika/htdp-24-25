;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 01-introduction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Úvod do programování - programovací jazyk Beginning Student Language

;; V levém dolním rohu zvolte programovací jazyk "Beginning Student"

;; Toto je oblast definicí

;; Stisknutím "Run" v pravém horním rohu zobrazíte interakční oblast

;; Zkusme do interakční oblasti vložit
#; "toto je interakční oblast"



;; Hodnoty mají různé datové typy

; - String ---> Text (textový řetězec)
#;"textový řetězec,
může mít i více řádků...
...
"

; - Number ---> Číslo
#;0
#;42
#;-57

; - Bool ---> Pravdivostní hodnota (boolean)
#;#true
#;#t
#;#T
#;#false
#;#f
#;#F

;; V programování kombinujeme jednotlivé hodnoty a provádíme na
;; nich operace (výpočty)

;; Celé programy se tedy skládájí z tzv. výrazů (expressions)
;; Výrazy se vyhodnocují a výsledné hodnoty se zobrazí v oblasti interakcí

;; V jazyce Beginning Student Language (BSL) je výraz buďto
;; 1) přímo hodnota (např. číslo 6)
;; 2) něco, co začíná levou závorkou "(" a končí pravou závorkou ")"
;;    a obsahuje návod na vyhodnocení hodnoty

#;(+ 2 3) ; = 5

#;(+ 2 3 4 5 6) ; = 20

#;(* 3 3)

#;(- 4 2)

;; Beginning Student Language (BSL) používá tzv. prefixovou notaci,
;; výrazy které chceme vyhodnotit zapisujeme následovně:
;; 1) Zapíšeme počáteční levou závorku "("
;; 2) Zapíšeme operaci kterou chceme provést (např. +)
;; 3) Zapíšeme operandy (hodnoty na které má operace působit)
;; 4) Zapíšeme konečnou pravou závorku ")"

;; Cvičení:
;; Zapište následující výrazy do interakční oblasti a zkontrolujte
;; výsledky

;; 7 + 3

;; 8 + 2 + 10

;; 11 - 5

;; 10 - 2 - 2

;; 10 * 3




;; BSL samozřejmě umí více operací - např. sinus, mocnina, odmocnina

#;(sin 0)
#;(sqr 3)
#;(sqrt 9)

;; Výrazy můžeme skládat pomocí vnoření (nesting) - 2 + (3 * 5)

#;(+ 2 (* 3 5))

;; Nesting je "neomezený" (limitace pouze počítačem), odpovídá kompozici funkcí z matematiky

#;(sin (+ 0.1 0.1)) ; sin(0.1 + 0.1)

;; Cvičení
;; Zkuste vyhodnotit následující výraz "v hlavě"
#;(+ 5
   (* 2 2 (+ 1
             (* 3 7))
      4)
   2)


;; Cvičení
;; Zapište následující výraz v jazyce BSL a zkontrolujte jeho výsledek
;; (2 * 3) + (7 * (4 + 1))

;; Dokumentaci jednotlivých procedur nalezneme stisknutím F1 na vybraném výrazu

;; Nechceme pracovat pouze s čísly, ale i s jinými datovými typy



;; Aritmetika hodnot String
;; Podobně jako můžeme sčítat čísla, můžeme provádět operaci
;; složení stringů


#;(string-append "ab" "cd")
#;(string-append "cd" "ab")
#;(string-append "ab" "cd" "ef" "gh")


;; (Number, +) tvoří grupu
;;   (operace + je na Number asociativní, má neutrální prvek a inverzní prvek)
;; (String, string-append) tvoří monoid
;;   (string-append je na String asociativní, má neutrální prvek, nemá inverzní prvek)


;; Mezi typy lze převádět - mění se podoba hodnoty v počítači (reprezentace v paměti)
#;(string->number "52")
#;(number->string 52)

#;(string->number "not a number")

;; #false a #true jsou hodnoty typu Boolean - aritmetiku Booleanů si ukážeme příště
;; Nyní nám stačí že odpovídají hodnotám pravda/nepravda


;; Aritmetiku můžeme provádět např. i na obrázcích (v BSL datový typ Image)
;; Přidejme "teachpack" 2htdp/image - menu Language > Add Teachpack
;; Můžeme také přidat pomocí kódu - "požadujeme rozšíření 2htdp/image"
(require 2htdp/image)

#;(circle 10 "solid" "red")
#;(rectangle 30 20 "outline" "blue")

#;(overlay (circle 5 "solid" "red")
           (rectangle 20 20 "solid" "blue"))

;; Tato operace opět "odpovídá" operaci +, není však komutativní

;; Plátno pro datový typ Image
#; (empty-scene 50 50)

;; Mimo overlay můžeme také použít funkci place-image, kde specifikujeme
;; souřadnice na které se má Image vložit.
#;(place-image (circle 5 "solid" "green")
               50 90
               (empty-scene 100 100))
