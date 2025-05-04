;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 39-ast-and-interpreters) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; --- Abstract syntax tree ---

;; Strukturu stromu můžeme využít pro
;; reprezentaci defunkcionalizace
;; (reprezentujeme aplikaci funkcí
;; jako data)


;; Víme, že výraz
#; (or #t #f)
;; se vyhodnotí na
#; #t


;; Když stisknete Run, implementace
;; ISL+lambda ale musí přečíst zdrojový
;; kód a převést jej do spustitelné
;; reprezentace. Tato reprezentace
;; obashuje informaci o aplikaci
;; procedury or na hodnoty #t a #f
;; které se pak interpretuje na
;; výsledek #t

;; Zdrojový kód programovacích
;; jazyků se běžně převádí
;; mezi několika reprezentacemi
;; než se stane spustitelným.

;; Typicky je alespoň jednou
;; převeden na tzv Abstraktní Syntaktický
;; Strom (AST)

;; Tento strom reprezentuje kód jako
;; strom, který se podle určitých pravidel
;; vyhodnocuje.

;; V běžných jazycích se pak AST dále převádí
;; do optimalizovanějích reprezentací
;; (jako třeba bytecode pro nějakou stack machine),
;; můžeme ale interpretovat přímo
;; AST reprezentaci (tree-walk interpreter)


;; Výraz
#; (or #t #f)
;; můžeme v AST reprezentovat například
;; pomocí následujících datových typů

; Literal is one of:
; - "T"
; - "F"

(define-struct op-or [left right])
; OpOr is a struct:
#; (make-op-or Expression Expression)

; Expression is one of:
; - Literal
; - OpOr
;; AST of Boolean expression

(define or1 (make-op-or "T" "F"))

;; Tato reprezentace se k "or"
;; chová jako k čistě binárnímu
;; operátoru! Musí mít právě
;; dva argumenty.

;; Cvičení
;; Napište AST reprezentaci výrazů
#; (or
    (or #t #f)
    (or #f #f))




#; (or
    (or #f
        (or #f #f))
    #t)


;; Dále zavedeme predikát určující jestli je
;; hodnota literál (konkrétní hodnota, není
;; složeným výrazem)

; Expression -> Boolean
(define (literal? e)
  (and (string? e)
       (or (string=? e "T")
           (string=? e "F"))))


;; A predikát určující jestli je literál True

; Literal -> Boolean
(define (is-true? l)
  (string=? l "T"))


;; Cvičení
;; Zavedeme funkci eval

; Expression -> Literal
(check-expect (eval "T") "T")
(check-expect (eval "F") "F")
#;(check-expect (eval or1) #T)
(define (eval expr)
  (cond [(literal? expr) expr]
        [(op-or? expr) (eval-or expr)]))

;; Doplňte (nadesignujte) funkci eval-or,
;; která z hodnoty OpOr vytvoří Literal
;; podle logických pravidel.
;; Tato funkce by měla implementovat
;; McCarthyho evaluaci - využíjte lokální
;; prostředí pro rekurzi nejdříve po
;; levé větvi, poté po pravé.

; OpOr -> Literal
(define (eval-or expr)
  ...)



;; Funkce eval je interpret boolovských
;; výrazů

;; Při práci s booleany využíváme další
;; operátory:
#; (and #t #t)
#; (not #t)

;; Můžeme tedy zavést příslušné datové
;; struktury a rozšířit definici typu
;; Expression.

(define-struct op-and [left right])
; OpAnd is a struct:
#; (make-op-and Expression Expression)

(define-struct op-not [inner])
; OpNot is a struct:
#; (make-op-not Expression)

; Expression.v2 is one of:
; - Literal
; - OpOr
; - OpAnd
; - OpNot
;; AST of Boolean expression

;; Cvičení
;; Převeďte výrazy na AST reprezentaci
#; (and (or #t #f)
        (or #f #f))




#; (not (and (and #t #f)
             (not (or #f #f))))




;; Cvičení
;; Proveďte iterativní refinement
;; funkce eval:
;; - zaveďte definice funkcí eval-[op].v2
;;   pro všechny operátory
;; - tyto funkce použijte v eval.v2


; Expression.v2 -> Literal
(define (eval.v2 expr)
  ...)

; OpOr -> Literal
(define (eval-or.v2 expr)
  ...)

; OpAnd -> Literal
(define (eval-and.v2 expr)
  ...)

; OpNot -> Literal
(define (eval-not.v2 expr)
  ...)



;; AST reprezentaci můžeme využít i
;; k inspekci kódu - můžeme třeba
;; převést AST na "human readable"
;; výstup

;; Cvičení

;; Nadesignujte funkci print-ast,
;; která převede AST reprezentaci
;; na string reprezentující operace
;; které se provádí. Každou aplikaci
;; operace uzávorkujte.
;; Příklad:
#; (or
    (or #t #f)
    (or #f #f))
;; se převede na
#; "((T or F) or (T or F))"

#; (not (or #t #t))
;; se převede na
#; "(NOT (T or T))"






;; AST dále můžeme využít při
;; překladu kódu k nalezení
;; možných optimalizací.
;; Můžeme hledat kód který
;; je "zbytečné vyhodnocovat"
;; (více kroků vede na identitu)
;; a takový kód zredukujeme.
;; Příklad:
#; (not (not #t))
;; je to samé co
#; #t
;; takže
#; (make-op-not (make-op-not "T"))
;; můžeme převést pouze na
#; "T"

;; Optimalizace se běžně provádějí
;; ve více krocích -> postupně se
;; transformuje AST do optimalizované
;; verze.


; Expression.v2 -> Expression.v2
; "double-not is identity" optimization pass
(check-expect (optimize/double-not "T") "T")
(check-expect (optimize/double-not or1) or1)
(check-expect (optimize/double-not
               (make-op-not (make-op-not or1)))
              or1)
(check-expect (optimize/double-not
               (make-op-and (make-op-not (make-op-not "T"))
                            (make-op-not "F")))
              (make-op-and "T" (make-op-not "F")))
(define (optimize/double-not expr)
  (local (; Expression.v2 -> Expression.v2
          (define (optimize expr)
            (cond [(literal? expr) expr]
                  [(op-not? expr)
                   (remove-double expr)]
                  [(op-and? expr)
                   (make-op-and (optimize (op-and-left expr))
                                (optimize (op-and-right expr)))]
                  [(op-or? expr)
                   (make-op-or (optimize (op-or-left expr))
                               (optimize (op-or-right expr)))]))
          
          ; NotOp -> Expression.v2
          ; If inner is op-not returns optimized inner of inner
          ; If inner is not op-not, returns optimized
          (define (remove-double expr)
            (if (op-not? (op-not-inner expr))
                (optimize (op-not-inner (op-not-inner expr)))
                (make-op-not (optimize (op-not-inner expr))))))
    (optimize expr)))


;; Této metodě úpravy AST se říká term rewriting.


;; Dále můžeme zavést vyhodnocovací prostředí a definované
;; konstanty.

(define-struct variable [name])
; Variable is a struct
#; (make-variable name)

; Expression.v3 is one of:
; - Literal
; - Variable
; - OpOr
; - OpAnd
; - OpNot
;; AST of Boolean expression


;; Vyhodnocovací funkce nyní musí obsahovat
;; prostředí - mapování Variable -> Hodnota
;; které může interpreter využít

(define-struct binding [name value])
; VariableBinding.v3 is a struct
#; (make-binding String Literal)

; Environment.v3 is [List-of VariableBinding.v3]


; Environment.v3 String -> Literal
(define (get-value env variable-name)
  (cond [(empty? env)
         (error (string-append "Variable "
                               variable-name
                               " not found"))]
        [(cons? env) (if (string=? (binding-name (first env))
                                   variable-name)
                         (binding-value (first env))
                         (get-value (rest env) variable-name))]))


(define env1 (list (make-binding "x" "T")
                   (make-binding "y" "F")))

(define expr1 (make-op-and (make-op-not (make-variable "x"))
                           (make-op-or (make-variable "y")
                                       "T")))

;; Cvičení:
;; Proveďte iterativní refinement do verze v3
;; ve které je povolené mít zavedené
;; prostředí s bindingem variables.


; Environment.v3 Expression.v3 -> Literal
(define (eval.v3 env expr)
  (cond [(literal? expr) expr]
        [(variable? expr)
         (get-value env (variable-name expr))]
        [(op-not? expr)
         (eval-not.v3 env expr)]
        [(op-and? expr)
         (eval-and.v3 env expr)]
        [(op-or? expr)
         (eval-or.v3 env expr)]))

(define (eval-not.v3 env expr)
  ...)

(define (eval-and.v3 env expr)
  ...)

(define (eval-or.v3 env expr)
  ...)
