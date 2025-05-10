;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 40-generative-recursion) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ----------------- Generativní rekurze -----------------

;; Zatím jsme se setkali s funkcemi, které provádí tzv.
;; strukturální rekurzi - při designování funkce jsme se
;; mohli kouknout na definici dat, pokud byla sebe-referenční,
;; pak byla výsledkem také sebe-referenční funkce (a rekurze se
;; děla právě na místě, kde byla rekurzivní i definice dat)

;; Rekurzi ale lze použít i bez ohledu na strukturu dat.
;; Některé problémy lze vyřešit pomocí přeorganizování
;; do (sady) jiných problémů, jejichž řešení pak správně
;; zkombinujeme. Toto přeorganizování ale může ignorovat
;; strukturu původních dat.

;; Sample problem: chceme vytvořit funkci bundle,
;; která vezme číslo N a list 1Stringů a vytvoří "chunky" (balíky)
;; stringů délky N

; [List-of 1String] N -> [List-of String]                               
; Vytvoří stringy délky n z listu 1Stringů s
#;(define (bundle s n) '())

;; Podle receptu na design funkcí si napíšeme ukázky použití
;; na ukázkových datech. Očekáváme, že
#;(list "a" "b" "c" "d" "e" "f" "g" "h")
;; bude funkcí při n=2 převeden na
#;(list "ab" "cd" "ef" "gh")

;; Když použijeme n=3, nastává problém - zbydou nám písmena!
;; Výsledkem pak může být třeba
#;(list "abc" "def" "gh")
;; Nebo
#;(list "ab" "cde" "fgh")

;; Zkuste vymyslet alespoň další dvě možnosti!

;; Předpokládejme, že první možnost je ta, kterou chceme.
;; Test naší funkce pak vypadá následovně
(check-expect (bundle (explode "abcdefg") 3)
                '("abc" "def" "g"))

;; Musíme také kontrolovat "edge cases" - co když je list příliš krátký
;; pro bundle?
#;(check-expect (bundle '("a" "b") 3) '("ab"))

;; Co když je list prázdný?
#;(check-expect (bundle '() 3) '())

;; Dokážete vymyslet další?

;; Dále musíme napsat "template". To se ukáže jako problematické!

;; N rekurzivní, s atomické
#;(define (bundle s n)
    (cond
      [(zero? n) (...)]
      [else (... s ... n ... (bundle s (sub1 n)))]))

;; [List-of 1String] rekurzivní, n atomické
#;(define (bundle s n)
    (cond
      [(empty? s) (...)]
      [else (... s ... n ... (bundle (rest s) n))]))

;; [List-of 1String] a N jsou rekurzivní
#;(define (bundle s n)
    (cond
      [(and (empty? s) (zero? n)) (...)]
      [else (... s ... n ... (bundle (rest s) (sub1 n)))]))

;; Všechny možnosti!
#;(define (bundle s n)
    (cond
      [(and (empty? s) (zero? n)) (...)]
      [(and (cons? s) (zero? n)) (...)]
      [(and (empty? s) (positive? n)) (...)]
      [else (... (bundle s (sub1 n)) ...
             ... (bundle (rest s) n) ...)]))

;; Vidíme, že náš strukturální přístup nefunguje!
;; Máme 4 možné templates.

;; První dvě nemohou fungovat, funkce musí zpracovávat
;; oba parametry.

;; Třetí template toto dovoluje, ale předpokládá, že bundle
;; zpracovává oba argumenty "ve stejném tempu", což se ale neděje!
;; Argument n musíme ve chvíli co dojde na 0 resetovat do původní hodnoty!

;; Čtvrtý template je zase příliš "decoupled".
;; Procesování listu a odčítání musí být prováděno najednou.

;; Výsledek: Strukturální přístup je v tomto problému nepoužitelný!

;; Potřebujeme něco silnějšího - generativní rekurzi!

; [List-of 1String] N -> [List-of String]
; Vytvoří stringy délky n z listu 1Stringů s
; Idea: Vezměme n itemů, zároveň jich n zahoďme
(define (bundle s n)
    (cond
      [(empty? s) '()]
      [else
       (cons (implode (take s n)) (bundle (drop s n) n))]))


; [X] [List-of X] N -> [List-of X]
; Vezme prvních n prvků z listu l
(define (take l n)
  (cond
    [(zero? n) '()]
    [(empty? l) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))


; [X] [List-of X] N -> [List-of X]
; Odstraní prvních n prvků z listu l
(define (drop l n)
  (cond
    [(zero? n) l]
    [(empty? l) l]
    [else (drop (rest l) (sub1 n))]))



;; Tyto definice tvoří kompletní definici bundle.
;; 1) Pokud je list '(), vrátíme '(), jak nám udává ukázka použití

;; 2) Jinak vezmeme prvních n 1Stringů z s a použijeme na ně implode,
;;    což je spojí v jeden string

;; 3) Dále provádíme rekurzi se zmenšeným listem, což zařídí funkce drop

;; 4) Nakonec cons zkombinuje string ze 2 s listem který dostaneme v dalším
;;    rekurzivním volání funkce


;;  Krok 3 je ten hlavní rozdíl mezi funkcí bundle a jakoukoliv jinou funkcí,
;; se kterou jsme se zatím setkali! Namísto first a rest, které používáme ve
;; strukturální rekurzi, zde máme použitou funkci drop, která nehledí na strukturu,
;; ale rovnou odstraní n prvků listu!

;; Pokud je délka chunku 1, problém se redukuje na strukturální rekrurzi!
;; Zkuste vysvětlit proč!

;; Rozmyslete: Je použití
#;(bundle '("a" "b" "c") 0)
;; validní použití? Co je výsledkem takové funkce? Proč?

;; Co musí garantovat funkce drop?






;; Strukturální rekurze garantuje terminaci programu - tím, že
;; procházíme strukturu v opačném směru její indukce, máme jistotu
;; že dojdeme do base case, kde se algoritmus ukončí.

;; To u strukturální rekurze nutně neplatí - (drop l 0) nikdy
;; neodstraní prvek z listu, nemáme zaručeno že se pro každý
;; vstup program ukončí.


; Procvičovací úloha:
; Vytvořte funkci list->chunks, která vezme list a přirozené číslo N
; a vrátí list listů o délce N



