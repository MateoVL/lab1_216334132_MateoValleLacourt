#lang racket
(provide piece)
(provide piece-get-name)
(provide piece-get-piece)


;;;TDA piece: Estructura que representa una pieza con un par, el cual guarda la palabra de su color y una representacion de ficha para el tablero.



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