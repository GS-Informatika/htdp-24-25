;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 41-sorting-revisited) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; V některých případech existuje správný algoritmus, který
;; postupuje podle struktury dat, ale je výhodnější volit algoritmus
;; který přirozenou strukturu ignoruje.

;; Vzpomeňme si na insert sort

; [List-of Number] -> [List-of Number]
(define (sort> alon)
  (cond
    [(empty? alon) '()]
    [else
     (insert (first alon) (sort> (rest alon)))]))

; Number [List-of Number] -> [List-of Number]
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

;; Tento algoritmus postupuje podle struktury a vždy vkládá první číslo v listu
;; "na místo kam přesně patří".

;; Hoareův quick-sort je pak odlišný algoritmus, který ignoruje strukturu listu
(define list1 (cons 6 (cons 5 (cons 8 (cons 12 (cons 1 '()))))))
;; a je "klasickou ukázkou" generativní rekurze. Generativní krok používá
;; strategii "divide and conquer" (rozděl a panuj), rozdějuje netriviální části
;; problému na dva menší (a blízké) subproblémy. Řešení těchto subproblémů pak
;; zkombinuje do celkového výsledku.

;; 1) Vybereme číslo z listu (např. první číslo) - pivot
;; 2) Rozdělíme list čísel k seřazení na list menších a větších čísel, než je pivot
;; 3) Seřadíme tyto sublisty pomocí quick-sortu
;; 4) Výsledky spojíme dohromady, pivot vložíme mezi dva seřazené sublisty

; [List-of Number] -> [List-of Number]
(check-expect (quick-sort< list1) '(1 5 6 8 12))
(check-expect (quick-sort< '()) '())
(check-expect (quick-sort< '(1 2)) '(1 2))
(define (quick-sort< lst)
  (cond
    [(empty? lst) '()]
    [else (local (
                  (define pivot (first lst))
                  (define larger (filter (lambda (i) (> i pivot)) lst))
                  (define smaller (filter (lambda (i) (< i pivot)) lst)))
            (append (quick-sort< smaller) (list pivot) (quick-sort< larger)))]))

;; Tento algoritmus naprosto ignoruje strukturu listu!
;; Rekurze obecně nepracuje na elementech které za sebou následují!

;; Procvičovací úloha:
;; Abstrahujte quick-sort funkci tak, aby brala za argument funkci [A]: (A A -> Bool) porovnávající
;; dva prvky a používala ji k filtrování listu




;; Zkuste navrhnout funkci, která vytvoří listy larger a smaller jedním průchodem listu.
;; Jako první navrhněte datovou strukturu, která může reprezentovat výsledek takové funkce.





;; Dalším generativně rekurzivním algoritmem je merge sort.
;; Jeho asymptotická složitost je stejná jako u quick sortu
;; O(n log(n))

;; Jeho princip spočívá v tom, že máme triviálně řešitelnou
;; úlohu (triviálně je v tomto kontextu odborný termín!)
;; seřazení prázdného listu nebo listu o jednom prvku.

;; Problém seřazení pak převedeme na problém jak "spojit"
;; dva již seřazené listy.

;; Abychom se dostali k triviálně řešitelnému problému,
;; rozdělíme list v rekurzivním kroku na poloviny.

; [List-of Number] -> [List-of Number]
; Seřadí list pomocí spojování seřazených listů (merge sort)
(check-expect (merge-sort '(80 60 70 50 30 40))
              '(30 40 50 60 70 80))
(check-expect (merge-sort '(1 4 2))
              '(1 2 4))
(check-expect (merge-sort '(5))
              '(5))
(check-expect (merge-sort '())
              '())
(define (merge-sort l)
  (local (; [List-of Number] [List-of Number] -> [List-of Number]
          ; Spojí dva seřazené listy tak, aby výsledek byl seřazený
          (define (merge xs ys)
            (cond [(empty? xs) ys]
                  [(empty? ys) xs]
                  [(< (first xs) (first ys))
                   (cons (first xs) (merge (rest xs) ys))]
                  [(>= (first xs) (first ys))
                   (cons (first ys) (merge xs (rest ys)))]))

          ; [T]: Nat [List-of T] -> [List-of T]
          (define (take n lst)
            (if (or (empty? lst) (= 0 n))
                '()
                (cons (first lst) (take (sub1 n) (rest lst)))))
          ; [T]: Nat [List-of T] -> [List-of T]
          (define (drop n lst)
            (if (or (empty? lst) (= 0 n))
                lst
                (drop (sub1 n) (rest lst))))

          (define (sort l)
            (cond [(empty? l) l]
                  [(empty? (rest l)) l]
                  [else (local (; Number
                                (define half
                                  (ceiling (/ (length l) 2))))
                          
                          (merge (sort (take half l))
                                 (sort (drop half l))))])))
    
    (sort l)))


;; Generativní krok nemá žádnou spojitost se strukturou dat,
;; v hlavičce funkce bychom tedy měli ujasnit "jak"
;; funkce dosáhne svého výsledku.


;; Generativní rekurze tedy rozeznává dva typy problémů:
;; 1) triviálně řešitelné - dokážeme přímo určit výsledek
;; 2) netriviální - tyto problémy převádíme na menší subproblémy,
;;    které řešíme rekurzivně (dokud nedojdeme k
;;    triviálně řešitelnému problému) a výsledky následně
;;    zkombinujeme.

;; Dále jsme se také potkali s problémem "terminace".
;; Některé problémy pro určité vstupy nevygenerují žádný
;; výsledek, výpočet se nikdy neukončí - říká se, že
;; se funkce zacyklika, nebo je v nekonečném cyklu.

;; Při psaní generativních algoritmů bychom tedy měli
;; specifikovat, pro jaká data může k zacyklení dojít.
