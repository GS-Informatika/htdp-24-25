;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 36-streams) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Listy mohou obsahovat nekonečný počet hodnot jen teoreticky,
;; v realitě jsme omezeni pamětí runtime a náročností
;; vytvoření listu.

;; Někdy ale chceme mít funkcionalitu, kde cheme nekonečný
;; počet hodnot vytvořit - nevíme dopředu, kolik
;; hodnot bude potřeba.

;; Vytvořit list s nekonečným počtem hodnot nemůžeme
#; (build-list 10000000 add1)

;; Zároveň tvorba listu může zabrat netriviální
;; výpočetní čas

;; Místo toho můžeme použít tzv. streamy - datové
;; struktury, které lze použít k modelování stavu
;; programu

;; ISL v abstraction.rkt přímo poskytuje několik streamů (sekvencí)
(require 2htdp/abstraction)
#;(in-range 200)
#;(for/list ([i (in-range 10)])
  i)
#;(in-naturals 10)
#;(for/list ([i (in-range 20)]
      [j (in-naturals 100)])
  (+ i j))

;; Porovnejme jak dlouho trvá výpočet při
;; vytvoření listu a při použití streamu

; [T]: T -> T
(define (id x) x)

(define COUNT 10000000)

#;(time (for/sum ([i (build-list COUNT id)]) i))
#;(time (for/sum ([i (in-range COUNT)]) i))

;; Pomocí streamů můžeme také odstranit část výpočtů
;; které musí program provést


; [Pair L R] is a struct
#; (make-pair L R)
(define-struct pair [left right])
; Pair of two values

; [T]: [List-of T] -> [List-of [Pair Nat T]]
(define (enumerate.v1 l)
  (for/list ([item l]
             [idx (length l)])
    (make-pair idx item)))


; [T]: [List-of T] -> [List-of [Pair Nat T]]
(define (enumerate.v2 l)
  (for/list ([item l]
             [idx (in-naturals 0)])
    (make-pair idx item)))

; [T A]: (T -> A) T -> Void
; Calculate and throw result away
(define (no-eval1 fn arg)
  (local ((define throw-away (fn arg)))
    void))

(define A-LIST (build-list 10000000 id))
(time (no-eval1 enumerate.v1 A-LIST))
(time (no-eval1 enumerate.v2 A-LIST))

;; Vestavěné streamy typicky umožňují runtime
;; provádět optimalizace.
;; Využívá se "zpožděná evaluace" (delayed evaluation)


;; Naše vlastní implementace bude pomalejší,
;; ale umožňí konstruovat sekvence hodnot které
;; by se v listu do paměti nevešly.

;; Pro implementaci dočasně přejdeme do jazyka ASL,
;; budeme totiž potřebovat funkce které nekonzumují
;; žádnou hodnotu.


; [ConsStream T] is a struct
#; (make-stream T (-> [ConsStream T]))
(define-struct stream [first rest-delayed])

;; Struktura streamu je podobná struktuře listu
;; V "rest" poli ale nemáme přímo zbytek streamu,
;; ale funkci která zbytek streamu vytvoří.
;; Tato funkce pak musí obsahovat data nutná pro
;; vygenerování zbytku streamu.

; Number -> [ConsStream T]
; Infinite stream of numbers starting at start.
(define (numbers start)
  (make-stream start (lambda ()
                       (numbers (add1 start)))))

#;(numbers 1)

; [Stream T] is one of:
; - '()
; - [ConsStream T]

; [T]: [ConsStream T] -> [Stream T]
(define (stream-rest stream)
  ((stream-rest-delayed stream)))

#; (stream-rest (numbers 1))

; [T]: [Stream T] -> [List T]
; Evaluates stream, collecting values to a list
(define (stream->list stream)
  (cond [(empty? stream) '()]
        [(stream? stream)
         (cons (stream-first stream)
               (stream->list (stream-rest stream)))]))

; [T]: Number [Stream T] -> [Stream T]
; Creates stream containing at most n items from
; original stream.
(define (stream-take n stream)
  (cond [(= n 0) '()]
        [(empty? stream) '()]
        [else (make-stream
               (stream-first stream)
               (lambda () (stream-take (sub1 n)
                                        (stream-rest stream))))]))
#;(stream->list
 (stream-take 10 (numbers 5)))
   
#;(stream->list
 (stream-take 20 (stream-take 10 (numbers 0))))

; [T1 T2]: [T1 T2 -> T2] T2 [Stream T1] -> T2
; Folds finite stream to a single value.
(define (stream-foldl fn acc stream)
  (cond [(empty? stream) acc]
        [else (stream-foldl fn
                            (fn (stream-first stream) acc)
                            (stream-rest stream))]))

(define LARGE-COUNT (* COUNT 5))
#;(foldl + 0 (build-list LARGE-COUNT id))
#;(stream-foldl + 0 (stream-take LARGE-COUNT (numbers 0)))


;; Cvičení
;; 1) Nadesignujte funkci, která vytvoří stream
;;    sudých (even) čísel větších než n.




;; 2) Nadesignujte funkci, která vytvoří cyklický
;;    stream čísel od start do end:
;;    (cycle 0 2) bude postupně vytvářet hodnoty
;;    0, 1, 2, 0, 1, 2, 0, 1, 2.
;;    Hint: budete potřebovat lokální prostředí
;;    a pomocnou funkci která bude konzumovat
;;    momentální stav.




;; 3) Inspirujte se ukázkou implementace funkcí map
;;    a filter pro listy z minulých lekcí.
;;    Nadesignujte funkce stream-map a filter-map.



