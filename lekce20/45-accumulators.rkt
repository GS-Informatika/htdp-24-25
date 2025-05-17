;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 45-accumulators) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; --- Problém zapomínání ---

;; Když v ISL+ aplikujeme funkci "f"
;; na nějáký argument "a", obdržíme
;; výsledek v == (f a). Pokud provedeme
;; stejnou operaci podruhé, obdržíme opět
;; stejný výsledek - v. Říkáme, že taková
;; operace je nezávislá na kontextu.
;; Je nám jedno kde aplikaci funkce provedeme:
;; jestli v interakčním okně,
;; v oblasti definic, uvnitř lambdy,
;; jako samostatný výraz (funkci) nebo jako
;; součást nějákého většího výrazu.

;;  Tento princip je kritický pro tvorbu
;;  rekurzivních funkcí - můžeme vždy předpokládat,
;; že funkce vrátí přesně to, co slibuje v sepsaném
;; účelu funkce a hlavičce. Nezávislost na kontextu
;; ale také přináší určité problémy:
;; 1) Ztrácíme "znalost" předchozích rekurzivních
;;    volání - funkce neví, jestli je součástí
;;    rekurzivního volání, pokud není
;;    tail call (nebo jazyk tail calls nepodporuje)
;;    dochází k budování call stacku - může být
;;    problematické na paměť!
;; 2) V případě strukturní rekurze může
;;    způsobit, že musíme některé části
;;    dat projí vícekrát a bude nás to
;;    stát výpočetní čas (lze obejít pomocí
;;    lokálních definic). Pro generativně
;;    rekurzivní funkce to může dokonce způsobit,
;;    že nedokáží vrátit výsledek vůbec
;;    (např. vyhledávání v grafu pro cyklický graf)!

;; Tuto ztrátu budeme řešit přidáním parametru,
;; ve kterém se momentální kontext bude předávat:
;; tzv. akumulátor.
;; Zároveň se naučíme převést některé
;; rekurzivní funkce na tail-rekurzivní!

;; Klíčové bude porozumět rozdílu mezi
;; "standardními" argumenty a akumulátory.

;; Sample problem - máme délky mezi jednotlivými
;; body cesty, chceme určit vzdálenost
;; od začátku cesty ke každému bodu

;; ----- | ---- | ------- | --- | --- | -----
;;  50      40       70      30    30

;; ----- | ---- | ------- | --- | --- | -----
;;      50     90        160   190   220


; [List-of Number] -> [List-of Number]
(check-expect (distance/origin '(50 40 70 30 30))
              '(50 90 160 190 220))
(define (distance/origin l)
  (cond [(empty? l) '()]
        [else (local (
                      ; Number [List-of Number] -> [List-of Number]
                      ; Přičte číslo ke každému prvku listu
                      (define (add-to-each n l)
                        (cond
                          [(empty? l) '()]
                          [else (cons (+ (first l) n) (add-to-each n (rest l)))]))
                      (define rest-of-l
                        (distance/origin (rest l)))
                      (define adjusted
                        (add-to-each (first l) rest-of-l)))
                (cons (first l) adjusted))]))

;; Tento program je sepsaný pomocí
;; strukturální rekurze a má zásadní problém.

(define SIZE 1000)
(time (distance/origin (build-list SIZE add1)))
;; S rostoucím SIZE je potřeba mnohem více operací

;;  SIZE      1000   2000   3000   4000   5000   6000   7000
;;  "čas"     x      x      x      x      x      x      x

;; Čas se při každém zdvojnásobení kroků vynásobí čtyřmi!
;; Algoritmus je O(n^2)

;; Procvičovací úloha - přeformulujte ¨
;; add-to-each pomocí "map" a "lambda"





;; Abychom sepsali "lepší" algoritmus,
;; potřebujeme si v každém rekurzivním kroku
;; pamatovat předchozí výsledek - pak stačí
;; přičítat! Zkusme vytvořit takový
;; akumulátor!

(define (distance/origin/a l acc)
  (cond
    [(empty? l) '()]
    [else
     (local ((define tally (+ (first l) acc)))
       (cons tally
             (distance/origin/a (rest l) tally)))]))

;; Nyní je každý prvek v listu zpracován jen jednou!

;;  Tuto funkci by ale nyní někdo mohl použít
;; "špatně" - aby byl výpočet správný, musí být
;; pro první volání argument acc = 0,
;; jinak dostaneme výsledek posunutý
;; o číslo které se nachází v akumulátoru
;; v prvním volání.

;; Můžeme využít lokální funkce!
(define (distance/origin/a.v2 l)
  (local ((define (d/o/acc l acc)
            (cond
              [(empty? l) '()]
              [else (local ((define tally (+ (first l) acc)))
                      (cons tally
                            (d/o/acc (rest l) tally)))])))
    (d/o/acc l 0)))



;; Zkuste navrhnout, jak akumulátory řeší problém s procházením cyklických grafů.
;; Jako procvičovací úlohu zkuste implementovat vyhledávání cesty mezi vrcholy
;; grafu, který bude pomocí akumulátoru ukončovat procházky po cyklických
;; částech.



