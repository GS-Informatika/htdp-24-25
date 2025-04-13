;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 33-bst) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ------ Binární vyhledávací stromy ------

;; BST jsou speciální případ stromu se
;; strukturou kde každá node (až na
;; listy) má právě dvě hrany které
;; z ní vedou.

;; Zavedeme je pomocí strukturního typu

; [BSTNode T] is a struct:
#; (make-bst-node T [BST T] [BST T])
; Node of binary search tree
(define-struct bst-node [value left right])

; [BST T] is one of
; - [BSTNode T]
; - "empty"
; Binary search tree

;; "empty" jsou listy stromu, nenesou
;; žádnou informaci.

;; BST kromě struktury splňují i takzvaný
;; "BST Invariant" - všechny prvky v
;; levém sub-stromu jsou menší než hodnota
;; a všechny prvky v pravém sub-stromu jsou
;; větší než hodnota.

(define BST-1
  (make-bst-node 10
                 (make-bst-node 5
                                "empty"
                                (make-bst-node 7 "empty" "empty"))
                 (make-bst-node 20
                                (make-bst-node 14
                                               (make-bst-node 12 "empty" "empty")
                                               (make-bst-node 19 "empty" "empty"))
                                (make-bst-node 25 "empty" "empty"))))


;; Při vyhledávání konkrétního prvku v BST
;; pak můžeme kontrolovat momentální hodnotu
;; a víme, že pokud hledáme menší, musíme
;; prohledat levý subtree a pokud hledáme větší,
;; musíme prohledat pravý subtree.


;; Vyhledávání ve stromu - pomocí strukturní rekurze

; Any -> Boolean
(define (bst-empty? t)
  (and (string? t)
       (string=? t "empty")))


; [BST T] [T T -> Boolean] [T T -> Boolean] T -> Boolean
(define (bst-contains? tree eq? larger? value)
  (cond [(bst-empty? tree) #f]
        [(bst-node? tree)
         (cond [(eq? value (bst-node-value tree)) #t]
               [(larger? value (bst-node-value tree))
                (bst-contains? (bst-node-right tree) eq? larger? value)]
               [else
                (bst-contains? (bst-node-left tree) eq? larger? value)])]))


;; Cvičení
;; Vytvořte funkci is-bst? která pro [BST T] určí,
;; jestli je splněn BST invariant.





