;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 38-simultaneous-processing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; --- Současné zpracovávání ---

;; Sample problem 1:

; [List-of Number] [List-of Number] -> [List-of Number]
; replaces the final '() in front with end
#; (define (replace-eol-with front end)
  ...)



;; Zpracováváme pouze jeden list,
;; druhý argument je atomický



;; Sample problem 2:

; [List-of Number] [List-of Number] -> [List-of Number]
; multiplies the corresponding items on hours and wages/h 
; assume the two lists are of equal length 
#; (define (wages* hours wages/h)
  ...)



;; Zpracováváme oba dva listy najednou - "lockstep"



;; Sample problem 3:

; [T] [List-of T] N -> T
; extracts the nth member of l, 
; signals an error if there is no such member
#; (define (list-pick l n)
  ...)



;; Je třeba uvědomit si, co vše ukončuje
;; vyhodnocování!
;; Musíme projít všechny možnosti
