;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 32-trees) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ------- Stromy -------

;; Stromy jsou struktura která se skládá z
;; vrcholů (node), které spojují orientované
;; hrany (edge) tak, že ke každému vrcholu
;; vede pouze jedna hrana (z vrcholu ale může
;; vést více hran).

;; Kořen stromu (root) je vrchol, ke kterému
;; nevede žádná hrana.

;; List stromu (leaf) je prvek, ze kterého
;; nevedou žádné hrany.


;; Příkladem stromu je rodokmen jednoho člověka.
;; Kořen takového stromu je daný člověk,
;; hrany pak vedou k jeho rodičům

;; Strukturní typ pro záznam rodokmenu pak může být

; Child is a struct:
#; (make-child Child Child String Nat)
#; (define-struct child [father mother name born-year])

;; Takový datový typ je ale nepoužitelný!

;; Diskuze - proč?




;; Na chvíli zanedbejme nemožnost zkonstruovat hodnotu
;; typu Child a předpokládejme, že již máme
;; hodnoty typu child: Karel a Anna
;; Jejich dítě Adam pak bude definováno jako
#; (define Adam
     (make-child Karel Anna "Adam" 1990))

;; Abychom mohli vytvořit hodnoty, potřebujeme "někde zastavit"
;; Stromy jsou rekurzivní datová struktura - stejně jako Listy
;; potřebují base case!

(define NP "no-parent")
(define-struct child [father mother name born-year])
; FT (zktratka pro FamilyTree) je jedno z:
;  - NP
#; (make-child FT FT String Nat)

; FT -> Boolean
; Určí jestli je child NP
(define (NP? child)
  (and (string? child)
       (string=? NP child)))

;; Nyní můžeme definovat rodokmen!
(define Jan (make-child NP NP "Jan" 1896))

(define Josef (make-child NP NP "Josef" 1920))
(define Tereza (make-child NP NP "Tereza" 1925))
(define Jana (make-child NP NP "Jana" 1930))
(define Rudolf (make-child Jan NP "Rudolf" 1929))

(define Karel (make-child Josef Tereza "Karel" 1962))
(define Anna (make-child Jana Rudolf "Anna" 1965))
(define Klara (make-child Jana Rudolf "Klára" 1960))

(define Adam (make-child Karel Anna "Adam" 1990))

;; Abychom definovali funkci která zpracuje strom,
;; budeme postupovat stejně jako u listů

; FT -> ???
; ...
(define (funkce-FT ftree)
  (cond [(NP? ftree) ...]
        [(child? ftree)
         (... (funkce-FT (child-father ftree)) ...
          ... (funkce-FT (child-mother ftree)) ...
          ... (child-name ftree) ...
          ... (child-born-year ftree) ...)]))


;; Z takové template dokážeme vytvořit funkce pracující nad
;; stromy (pomocí doplnění do template a abstrakce a dalších
;; pozorování o tvaru dat)

;; Funkce která určí, jestli strom obsahuje člověka narozeného před
;; daným rokem

;; Number FT -> Boolean
;; Určí, jestli ftree obsahuje člověka narozeného před rokem year
(define (has-born-before year ftree)
  (cond [(NP? ftree) #false]
        [(child? ftree)
         (if (< (child-born-year ftree) year)
             #true
             (or (has-born-before year (child-father ftree))
                 (has-born-before year (child-mother ftree))))]))


;; Cvičení - napište pomocí template funkci, která určí počet
;; lidí ve FT narozených po daném roce.
;; Hint - co můžete říct o polích child-mother a child-father?






;; ---------------------------------------------------


;; Můžeme vytvořit obecou strukturu stromu
(require 2htdp/image)

; [Tree T] is as a struct:
#; (make-tree-node T [List-of [Tree T]])
(define-struct tree-node [value children])

;; S touto reprezentací můžeme využít
;; abstrakcí z minulých lekcí

; [Tree Number]
(define T1
  (make-tree-node
   10 (list
       (make-tree-node 5 '())
       (make-tree-node
        3 (list
           (make-tree-node
            2 (list
               (make-tree-node -10 '())))
           (make-tree-node 0 '()))))))


; Image -> Image
(define (with-border padding color image)
  (overlay image
           (rectangle (+ padding (image-width image))
                      (+ padding (image-height image))
                      "outline" color)))

; [T -> String] [Tree T] -> Image
(define (draw-tree repr t)
  (local (; [Tree T] -> Image
          (define (draw-subtree-image tree)
            (with-border 4 "black" (draw-tree repr tree)))

          ; [Tree T] -> Image
          (define (draw-root tree)
            (text (repr (tree-node-value tree))
                                 12 "black"))
          
          ; [List-of Image]
          (define subtree-images
            (map draw-subtree-image (tree-node-children t)))

          ; Image
          (define subtree-image
            (foldl (lambda (img acc)
                     (beside/align "top" acc img))
                   empty-image
                   subtree-images))
          ; Image
          (define root-image (draw-root t)))
    (with-border 4 "black" (above/align "center" root-image subtree-image))))

#; (draw-tree number->string T1)


;; Jak už jsme viděli, často chceme nad stromy dělat
;; agregace - určit počet prvků (splňující nějaký predikát),
;; nalézt nějaký prvek, provést fold...


;; Ukázka: hloubka stromu

;; Podle design recipe - použití pomocné funkce
;; a vzájemné (provázané) rekurze

; [T]: [Tree T] -> Number
; Determines depth of tree
(check-expect (tree-depth (make-tree-node 0 '())) 1)
(check-expect (tree-depth
               (make-tree-node 0 (list (make-tree-node 1 '()))))
              2)
(define (tree-depth tree)
  (local (; [List-of [Tree T]] -> Number
          ; Determines depth of the most deep tree in a list
          (define (max-depth lot)
            (cond [(empty? lot) 0]
                  [(cons? lot)
                   (max (tree-depth (first lot))
                        (max-depth (rest lot)))])))
    (add1 (max-depth (tree-node-children tree)))))


;; Pomocná funkce zjednodušuje implementaci. V datové definici
;; máme vnořený rekurzivní typ - zavedení pomocné funkce
;; umožňuje provést rekurzi ve venjším typu (list) a pro každý
;; prvek pak provedeme rekurzi vnitřního typu (tree).


;; Můžeme také použít abstrakce - složitější vymyslet!

; [T]: [Tree T] -> Number
(check-expect (tree-depth.v2 (make-tree-node 0 '())) 1)
(check-expect (tree-depth.v2
               (make-tree-node 0 (list (make-tree-node 1 '())))) 2)
(define (tree-depth.v2 tree)
  (local (; [List-of Number]
          (define depths (map tree-depth.v2
                              (tree-node-children tree)))
          (define max-depth (foldl max 0 depths)))
    (add1 max-depth)))


;; Cvičení:

;; 1) Napište funkci, která určí součet čísel
;;    ve stromu [Tree Number]





;; 2) Napište funkci, která určí délku nejdelšího
;;    stringu ve stromu [Tree String]





;; 3) Definujme strukturní datový typ

; Person is a struct
#; (make-person String String Number)
; Represents a person.
(define-struct person [first-name surname year-born])

;;    Napište funkci, která nalezne všechny lidi,
;;    kteří se narodili před daným rokem.



