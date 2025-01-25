;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 08-designing-data) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; -- O designování software a programování --

;; K programování je potřeba mistrovství v mnoha
;; konceptech.

;; Na jednu stranu potřebujeme jazyk, kterým
;; programy píšeme a kterým komunikujeme co je
;; potřeba vypočítat/provést.
;; Programovací jazyky jsou umělé konstrukty, ale
;; s reálnými jazyky mají určitou podobnost:
;; - mají slovní zásobu (klíčová slova)
;; - mají gramatiku
;; - "fráze" mají význam

;; Na druhou stranu je potřeba naučit se, jak
;; se dostat od zadání problému k programu.

;; Musíme určit co je relevantní a co naopak
;; můžeme ignorovat. Zjistit co program konzumuje
;; a co produkuje (data) a jaká je relace mezi
;; vstupem a výstupem. Jestli jazyk ve kterém
;; programujeme poskytuje dostatečnou abstrakci
;; a funkce které k vyřešení problému potřebujeme,
;; nebo je budeme muset sami vyvinout...

;; Výsledek musíme otestovat, jestli opravdu provádí
;; očekávaný výpočet a nakonec je třeba sepsat alespoň
;; stručnou dokumentaci (a případně i záruky
;; funkcionality).


;; Proč od zadání až k výsledku jednoduše neprojdeme
;; přes experimentování a zkoušení a jakmile dostaneme
;; "něco co dostatečně dobře funguje" tak to označíme
;; za výsledek?
;; Tomu se říká "garage programming" (v češtině bastlení).
;; Často funguje! Ne však pro větší projekty kde očekáváme
;; spolupráci více lidí.

;; Programy píšeme pro jiné programátory ke čtení!
;; (a jiným programátorem můžete být i vy sami, když po
;;  nějaké době zapomenete na veškeré detaily implementace).
;; Je tedy nutné psát kód systematicky.



;; Domácí úkol:

; Popište, co je "year 2000 problem" ("y2k problem").
; Proč vznikl? Co byly jeho důsledky?


;; ------- Designování dat -------

;; Program je předpis ve tvaru:
;; INFORMACE ----> DATA ----> VÝPOČET ----> DATA ----> INFORMACE

;; Informace jsou prvky v doméně se kterou pracujeme,
;; pochází z "reality" (domény programu)

;; Data jsou naše reprezentace informací v
;; programovacím jazyce:
;;  - funkce
;;  - struktury
;;  - hodnoty

;; Informace nejprve převádíme do dat (reprezentace), data která
;; jsou výsledkem výpočtu pak převádíme zpět do informací
;; (interpretace)

;; Doména --reprezentace--> Program --inerpretace--> Doména

;; Výhoda BSL a DrRacket - převod z informace do dat je většinou
;; triviální


;; Diskuze - jaký význam má tento predikát?
(define (light4? number)
  (< (/ number 1.36) 4))

;; Bez znalosti na které doméně operuje nedokážeme určit.
;; Je třeba jej popsat!




;; Jedná se o podmínku pro klasifikaci lehké čtyřkolky
;; podle koňské síly
;; (dělení 1.36 převádí HP na kW,
;;  počet kW musí být menší než 4)


;; Protože je znalost, co data reprezentují (a jak je interpretovat) důležitá,
;; budeme psát definice dat - komentáře, které
;; 1) pojmenovávají data
;; 2) říkají, jak daná data vytvořit (reprezentovat) v programu
;; 3) říkají, jak daná data interpretovat (převést je na informaci)

;; Typicky jsou tyto komentáře v angličtině (není to ale nutnost).
;; Ukázka:



; Temperature is a Number
; Represents temperature in degrees Celsius




;; Datový typ je v BSL forma kontraktu - hodnoty Temperature
;; za běhu programu nelze odlišit od jiných čísel,
;; při psaní/čtení programu ale dodává informaci a kontext a
;; říká nám, jak hodnoty používat.


;; ------ Cvičení ------

;; 1) Zaveďte datovou definici pro typ 1String - String který má
;;    právě 1 znak.


; 1String is a String
; String with exactly 1 character



;; 2) Rozmyslete jestli je datový typ Temperature definovaný korektně.
;;    Najděte na internetu fyzikální limit pro teploty. Mohou programy
;;    používající definici Temperature výše reprezentovat teploty
;;    které nejsou fyzikálně možné?




;; ------ -------  ------

;; Podmínky (např. musí být větší než -273.15)
;; na datové typy si ukážeme později, prozatím budeme pracovat
;; s nedokonalými typy
