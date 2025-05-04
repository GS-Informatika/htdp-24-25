;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname HW-polynomials) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Polynomy a symbolické derivování

;; Polynomy a operace na nich můžeme interpretovat podobně jako
;; jsme interpretovali booleovské výrazy.

;; V případě polynomů rozlišujeme základní operace
;; 1) sčítání
;; 2) násobení

;; Data jsou pak
;; 1) Proměnná polynomu ("x", "y", ...)
;; 2) Konstanta (číslo)

(define-struct variable [name])
; Variable is a struct:
#; (make-variable String)


(define-struct add [left right])
; OpAdd is a struct:
#; (make-add Polynomial Polynomial)


(define-struct mult [left right])
; OpMult is a struct:
#; (make-mult Polynomial Polynomial)

; Polynomial is one of
; - Number
; - Variable
; - OpAdd
; - OpMult

;; Pro derivaci polynomů platí

;; Derivace konstanty/proměnné c podle x
;; -> dc/dx = 0 ;; pro c konstantu nebo proměnnou jinou než x
;; Například:
;;  - derivace 1 podle x je 0.
;;  - derivace k podle y je 0.

;; Derivace proměnné podle sama sebe
;;  -> dx/dx = 1

;; Derivace součtu polynomů
;; -> d(u + v)/dx = du/dx + dv/dx
;; Například:
;;  - derivace ((5 * x) + (7 * x)) je
;;     derivace (5 * x) + derivace (7 * x)

;; Derivace násobení polynomů
;; -> d(u * v)/dx = u * dv/dx + v du/dx
;; Například:
;;  - derivace ((5 + x) * (7 + x)) je
;;     (5 + x) * derivace (7 + x)
;;      + (7 + x) * derivace (5 + x)



;; Cvičení - pomocí pravidel pro derivaci polynomů napište funkci
;; symbolic-differentiate, která zderivuje polynom podle pravidel
;; výše. Napište si vhodné pomocné funkce.

;; 1) Idenfitikujte které struktury představují data a které
;;    představují operace (defunkcionalizace)




;; 2) Identifikujte listy (leafs) ve stromové struktuře polynomů




;; 3) Napište dvě ukázky polynomu který bude obsahovat více proměnných




;; 4) Napište predikát určující jestli jsou dvě proměnné stejné




;; 5) Napište funkci differentiate, která provede symbolickou derivaci podle
;;    proměnné.

;;    Převeďte pravidla pro derivace do funkcí v lokálním prostředí funkce
;;    differentiate.
;;    Tyto funkce budou očekávat příslušnou variantu
;;    z Polynomial typu a hodnotu
#;    (make-variable String)
;;    podle které bude derivováno.




;; 6) Výsledek není dobře čitelný. Vytvořme funkci ast->string,
;;    která převede naši reprezentaci polynomu do čitelného stringu




;; 7) Vidíme, že ve výsledku se vyskytují členy typu 0 * ..., které lze "vynechat".
;;    Napište funkci optimize/tree-shake, která odstraní členy které vždy výjdou 0.
;;    (Tree-shaking je název procedury která odstraňuje přebytečné větve ve stromové
;;     reprezentaci kódu).




;; 8) Přidejte variantu pro mocninu (expression^číslo)
;;    Pro derivaci mocniny proměnné platí následující pravidlo
;;    d(x^n)/dx = n * x^(n-1)
;;    Pro kompozici funkcí platí pravidlo
;;    ( f(g(x)) )' = f'(g(x)) * g'(x)
;;    Spojením těchto dvou pravidel dostáváme pravidlo které budeme
;;    implementovat:
;;    d( f(x)^n )/dx = n * f(x)^(n-1) * d( f(x) )/dx

;;    Upravte funkci differentiate tak, aby splňovala toto pravidlo.
;;    Upravte funkci to-str tak, aby zvládla zápis mocnin.
;;    Upravte funkci shake-tree tak, aby výraz (expr)^0 převedla na 1,
;;    výraz (expr)^1 převedla na (expr), výraz 0^n na 0. Pro výraz
;;    0^0 zvolte převod na 1.




;; 9) Vytvořte vhodnou strukturu pro variable binding (přiřazení
;;    hodnoty k proměnné). Napište funkci eval, která "vyhodnotí"
;;    polynom - vypočítá vše co půjde, dosadí za všechny proměnné
;;    které nalezne ve variable bindings.



