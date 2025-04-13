;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 32-iteration) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ------- CYKLY -------
(require 2htdp/abstraction)
(require 2htdp/image)

;; Abstrakce, které jsme si ukázali, v určitém smyslu zavádí i iterace přes struktury
;; (tedy cykly, které prochází strukturu a na každém prvku provádí operaci)

;; Vezměme si příklad funkce map - ta prochází list, na každém prvku provede
;; operaci a výsledky shromaždí do nového listu.

;; Tyto cykly se liší od cyklů v "běžných" jazycích
;; 1) cykly v běžných jazycích nutně nevytváří nová data,
;;    naše abstrakce jsou založeny na tvorbě nových dat
;;    z procházení "již existujících dat"


;; 2) "Běžné" jazyky mají obvykle jen omezený počet
;;    loop struktur, v ISL+ si "cykly" můžeme definovat
;;    dle potřeby - pomocí specializace


;; Běžné jazyky jako C, C#, Java, ... na cykly nahlíží jako
;; syntaktické konstrukty, podobně jako my máme konstrukty
;; cond nebo local - jejich zavedení vyžadovalo vysvětlení
;; gramatiky, názvosloví, scope ve kterém funguje a významu

;; Cykly jako syntaktická struktura mají určité výhody nad
;; funkcionálními loop strukturami co jsme si ukázali na minulé
;; lekci.

;; 1) Struktura takového loopu často lépe vyjadřuje záměry
;;    programátora, než kompozice funkcí.
;; 2) Implementace jazyka umí se syntaktickými loopy běžně
;;    zacházet lépe - přechází na "rychlejší" instrukce pro
;;    počítač


;; Funkcionální jazyky běžně poskytují i syntaktické loopy


#; (for/list (cls cls ...) expr)


#; (for/list ([i 10]) i)


#; (for/list ([num 5]
              [strs '("a" "b" "c")])
     (string-append strs (number->string num)))


#; (for/list ([num 5]
              [char "abcd"])
     (string-append char (number->string num)))


#; (local ((define width 3))
     (for/list ([width 5]
                [height width])
       (list width height)))


#;(local ((define width 3))
    (for*/list ([width 5]
                [height width])
      (list width height)))


;; Tyto struktury se "syntakticky liší jen o *",
;; ale mají velmi odlišný sémantický význam!

;; 1) Zkuste popsat scope jednotlivých proměnných v obou výrazech!
;; 2) Jak vyhodnocují jednotlivé for loopy jednotlivé klauzule?
;;    (paralelní x nested)

;;  Sémanticky se chování loopu mění v závislosti na tom, v co se
;; klauzule evaluuje. Klauzule vždy generuje sekvenci, přes kterou
;; se provádí loop. Podle toho, co výjde z klauzule se daná sekvence
;; vygeneruje. Pokud je výsledkem klauzule 
;; 1) číslo n, vygeneruje se sekvence 0 ... (n-1)
;; 2) list, sekvencí je samotný list
;; 3) string, iteruje se přes jednotlivá písmena

;; Každý průchod loopem (evaluace těla loopu) se nazývá iterace


;; Sample problem:
;; Definujme funkci enumerate, která vezme list
;; a vygeneruje list stejných elementů, spárovaných se
;; svým "indexem"


; [Pair L R] is a struct
#; (make-pair L R)
(define-struct pair [left right])
; Pair of two values


; [T]: [List-of T] -> [List-of [Pair Nat T]]
(define (enumerate lst)
  (for/list ([item lst]
             [idx (length lst)])
    (make-pair idx item)))


;; Sample problem 2:
;; Definujme funkci cartesian, která vezme dva listy
;; a vytvoří list všech dvojic (kartézský součin)

; [T1 T2]: [List-of T1] [List-of T2] -> [List-of [Pair T1 T2]]
(define (cartesian lst1 lst2)
  (for*/list ([item1 lst1]
              [item2 lst2])
    (make-pair item1 item2)))


;; Kromě for/list a for*/list konstrukce zavádíme další
;; for loop konstrukce, které agregují do jiných datových
;; typů

#; (for/and ([it '(a b c d)]) (symbol? it))
#; (for/or ([it '(1 2 3 4)]) (< it 0))
#; (for/sum ([str '("abc" "def" "abcdefgh")]) (string-length str))
#; (for/product ([image `(,(circle 8 "solid" "red")
                          ,(square 5 "solid" "red")
                          ,(right-triangle 8 12 "solid" "red"))]
                 [factor '(1 2 3 4)])
     (* (image-width image) factor))

#; (for/string ([char '("a" "b" "c" "d" "e")])
     char)

;; a jejich for*/ ... alternativy

