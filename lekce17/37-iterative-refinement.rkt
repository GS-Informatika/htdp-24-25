;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 37-iterative-refinement) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; --- Iterativní zpřesňování/vylepšování ---

;;  Při psaní "opravdových" programů se setkáte se
;; spoustou složitých domén informací a s problémem
;; jak takové informace reprezentovat pomocí dat.
;; Protože je pravděpodobné, že se nám nepovede udělat
;; vše správně na první pokus, používáme tzv.
;; iterative refinement (iterativní upřesňování).

;; Iterative refinement je metoda, ve které popisujeme
;; svět na různých úrovních přesnosti. Např. vědci a
;; technici pracující v kosmickém programu mohou při
;; určování dráhy letu raketoplánu nejprve začít s
;; jednoduchým modelem - raketoplán je bod letící vakuem!

;; Po formulaci modelu se udělají predikce a testování.
;; Pokud se reálné výsledky příliš liší od modelu, provede
;; se jeho vylepšení (např. raketoplán budeme uvažovat jako
;; tuhé těleso, nebo přidáme jednoduché působení atmosféry
;; při vzletu nebo přistání!). Opět opakujeme predikce a
;; testování a opět vylepšíme model, pokud jsou výsledy
;; testování příliš vzdálené od predikce modelu.

;; Cílem programátora je postupnou iterací nalézt vhodnou
;; reprezentaci reálných informací. Běžně se stává, že
;; musíme provést refinement až poté, co byla naše aplikace
;; spuštěna na živo (uživatelé chtějí novou funkcionalitu)!



;; Sample problém: Složky a soubory

;; Analýza
;;  Do počítače ukládáme soubory. To jsou víceméně
;; stringy, které mají jméno (reálně se jedná o
;; sekvence bytů, to ale nemusíme zatím řešit!).
;; Soubory členíme do složek, které mají také nějáké
;; jméno. Složka může obsahovat další složky.
;; Můžeme mluvit o stromech složek!

;;  Jak takové stromy reprezentovat, abychom mohli
;; psát programy, které se složkami a soubory pracují?

;; Model 1
;; Soubory jsou atomické entity, složky jsou jen "boxy"
;; do kterých soubory ukládáme

; Dir.v1 is one of:
; - '()
; - (cons File.v1 Dir.v1)
; - (cons Dir.v1 Dir.v1)

; File.v1 is a String

(define RT.v1 (list
               (list (list "2025_04" "2025_05" "README")
                     (list "HTDP" "DCIC"))
               "README"
               (list (list "BASH"
                           (list "README"))
                     "CAT"
                     (list "SH"))))

;; Sample problem: Definujme funkci how-many,
;; která určí kolik souborů Dir.v1 obsahuje.
;; Definujme funkci how-many-rec, která určí
;; kolik souborů obsahuje nějáká Dir.v1 a všechny
;; podsložky

; Dir.v1 -> Number
(check-expect (how-many.v1 RT.v1) 10)
(define (how-many.v1 dir)
  (cond [(empty? dir) 0]
        ; flattened
        ; [(cons? dir) (cond [(list? first) ...]
        ;                    [(string? first) ...]
        [(list? (first dir))
         (+ (how-many.v1 (first dir))
            (how-many.v1 (rest dir)))]
        [(string? (first dir))
         (+ 1 (how-many.v1 (rest dir)))]))


;; Cvičení:
;; Napište funkci, která určí počet výskytů souboru daného jména ve složce a podsložkách.



;; Model 2
;; Model 1 je sice jednoduchý, ale už nám umožní
;; pracovat se jmény a počty souborů
;; nicméně nemáme bližší informace o samotných
;; složkách. Abychom modelovali i složky,
;; musíme pro ně zavést vhodný sum-typ (strukturu).


; Dir.v2 is a struct:
#;(make-dir.v2 String LOFD)
(define-struct dir.v2 [name content])


; LOFD (List-of Files & Directories) is one of:
; - '()
; - (cons File.v2 LOFD)
; - (cons Dir.v2 LOFD)

; File.v2 je String

(define RT.v2
  (make-dir.v2 "ROOT"
               (list
                (make-dir.v2 "TEXT"
                             (list
                              (make-dir.v2 "DOCS"
                                           (list "2023_01"
                                                 "2023_02"
                                                 "README"))
                              (make-dir.v2 "BOOKS"
                                           (list "HTDP"
                                                 "DCIC"))))
                "README"
                (make-dir.v2 "BIN"
                             (list
                              (make-dir.v2 "LOCAL"
                                           (list "BASH"
                                                 (make-dir.v2 "DOCS"
                                                              (list "README"))))
                              "CAT"
                              (make-dir.v2 "USR"
                                           (list "SH")))))))



; Sample problem: Proveďme refinement funkcí how-many

; Dir.v2 -> Number
(check-expect (how-many.v2 RT.v2) 10)
(define (how-many.v2 d)
  (local (; LOFD -> Number
          (define (how-many-in l)
            (cond [(empty? l) 0]
                  [(dir.v2? (first l))
                   (+ (how-many.v2 (first l))
                      (how-many-in (rest l)))]
                  [(string? (first l))
                   (+ (how-many-in (rest l))
                      1)])))
    (how-many-in (dir.v2-content d))))


;; Procvičovací úloha: Nadesignujte funkci určující
;; počet souborů daného jména ve složce a podsložkách




;; Jak nyní složce přidáme další vlastnosti?
;; Např. "flags" (read-only, ...) nebo jméno vlastníka

;; Model 3
;; Stejně jako složky, i soubory mají nějáké
;; atributy - velikost, obsah, flags. Zaveďme
;; příslušný datový typ (zatím bez flags a content)!

(define-struct file.v3 [name length])

; File.v3 is a struct:
;   (make-file String N)

; Dále můžeme rozdělit obsah složky na soubory a podsložky

(define-struct dir.v3 [name dirs files])

; Dir.v3 is a struct:
#; (make-dir.v3 String Dir* File*)

; Dir* is one of:
; - '()
; - (cons Dir.v3 Dir*)

; File* is one of:
; - '()
; - (cons File.v3 File*)

(define RT.v3
  (make-dir.v3 "ROOT"
               (list
                (make-dir.v3 "TEXT"
                             (list
                              (make-dir.v3 "DOCS"
                                           '()
                                           (list
                                            (make-file.v3 "2023_01" 531)
                                            (make-file.v3 "2023_02" 121)
                                            (make-file.v3 "README" 235)))
                                   (make-dir.v3 "BOOKS"
                                                '()
                                                (list
                                                 (make-file.v3 "HTDP" 570)
                                                 (make-file.v3 "DCIC" 720))))
                             '())
                (make-dir.v3 "BIN"
                             (list
                              (make-dir.v3 "LOCAL"
                                           (list
                                            (make-dir.v3 "DOCS"
                                                         '()
                                                         (list
                                                          (make-file.v3 "README" 71))))
                                           (list
                                            (make-file.v3 "BASH" 830)))
                              (make-dir.v3 "USR"
                                           '()
                                           (list
                                            (make-file.v3 "SH" 972))))
                             (list
                              (make-file.v3 "CAT" 50))))
               (list
                (make-file.v3 "README" 20))))


; Sample problem: Refinement!

; Dir.v3 -> Number
(check-expect (how-many.v3 RT.v3) 10)
(define (how-many.v3 d)
  (local (
          (define file-count (length (dir.v3-files d)))
          (define in-subfolders (map how-many.v3 (dir.v3-dirs d)))
          (define total-in-subfolders (foldl + 0 in-subfolders)))
  (+ file-count total-in-subfolders)))


; Procvičovací úloha: Proveďte refinement funkce určující počet souborů daného jména ve složce
; a podsložkách.



