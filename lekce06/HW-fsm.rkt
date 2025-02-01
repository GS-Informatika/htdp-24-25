;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HW-fsm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Na lekci jsme si ukazovali FSM
;; reprezentující systém dveří.


;;     OPEN
;;   |      Ʌ
;; close    | 
;;   |     open
;;   V      |
;;    CLOSED
;;   |      Ʌ
;;  lock    |
;;   |    unlock
;;   V      |
;;    LOCKED


;; Pro každý element abecedy FSM (akci)
;; jsme zavedli funkci, která konzumovala stav
;; a produkovala následující stav (po působení
;; akce).

;; Nakonec jsme zavedli přechodovou funkci
;; (transition), která konzumovala akci a stav a
;; vyhodnotila funkci dané akce s daným stavem.
;; Výsledkem byl přechod do následujícího stavu.

;; FSM ale můžeme designovat i duálním způsobem:
;; - Pro každý stav zavedeme funkci konzumující
;;   akci a provádějící příslušný přechod.
;; - Transition funkce podle momentálního stavu
;;   vyhodnotí příslušnou funkci, která provede
;;   přechod.



; DoorState is a String
; One of "locked", "closed", "open".


; DoorAction is a String
; One of "lock", "unlock", "open", "close".



;; Pro každý DoorState nadesignujte jednu funkci,
;; která konzumuje DoorAction a provede příslušný
;; přechod



;; Nadesignujte funkci transition, která konzumuje
;; DoorState a DoorAction a vyprodukuje následující
;; DoorState. Tato funkce podle zkonzumovaného DoorState
;; vyhodnotí příslušnou funkci.
;; Postupujte podle Design Recipe který jsme si
;; ukazovali na lekcích.
