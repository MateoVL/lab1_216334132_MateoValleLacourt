#lang racket
(provide piece)
;(provide piece?)
(provide piece-get-name)
(provide piece-get-piece)


;;;TDA piece: Estructura que representa una pieza con la palabra de su color y una representacion de ficha con un par.



 ;;;;;;;;;;;;;;;;;
 ; CONSTRUCTORES ;
 ;;;;;;;;;;;;;;;;;


; Descripción: funcion que crea una ficha de conecta 4.
; Dom: color (string)
; Rec: pieza (piece)
; Tipo recursión: No aplica

(define piece
  (lambda (color)
    (cons color (string-upcase (string #\( (string-ref color 0) #\)))) ))




 ;;;;;;;;;;;;;;;
 ; PERTENENCIA ;
 ;;;;;;;;;;;;;;;


; Descripción: funcion que determina si una entrada dada es una ficha de conecta 4, revisa si es un string "red" o "yellow".
; Dom: dato (any)
; Rec: es-pieza? (boolean)
; Tipo recursión: No aplica

#|(define piece?
  (lambda (dato)
    (if (or (equal? dato "red") (equal? dato "yellow"))
        #t
        #f)))|#




 ;;;;;;;;;;;;;;
 ; SELECTORES ;
 ;;;;;;;;;;;;;;


; Descripción: funcion que entrega el nombre de la ficha.
; Dom: piece (piece)
; Rec: nombre ficha (string)
; Tipo recursión: No aplica

(define piece-get-name
  (lambda (piece)
    (car piece)))



; Descripción: funcion que entrega la representacion de la ficha.
; Dom: piece (piece)
; Rec: representacion ficha (string)
; Tipo recursión: No aplica

(define piece-get-piece
  (lambda (piece)
    (cdr piece)))




 ;;;;;;;;;;;;;;;;;
 ; MODIFICADORES ;
 ;;;;;;;;;;;;;;;;;



 ;;;;;;;;;
 ; OTROS ;
 ;;;;;;;;;