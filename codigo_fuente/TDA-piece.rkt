#lang racket
(provide piece)
(provide red-piece)
(provide yellow-piece)
(provide piece?)

;TDA piece: Estructura que representa una pieza con la palabra de su color.


;CONSTRUCTORES


; Descripción: funcion que crea una ficha de conecta 4.
; Dom: color (string)
; Rec: pieza (piece)
; Tipo recursión: No aplica

(define piece
  (lambda (color) color))

;creacion de fichas rojo y amarillo
(define red-piece (piece "red"))
(define yellow-piece (piece "yellow"))



;;PERTENENCIA


; Descripción: funcion que determina si una entrada dada es una ficha de conecta 4, revisa si es un string "red" o "yellow".
; Dom: dato (any)
; Rec: es-pieza? (boolean)
; Tipo recursión: No aplica
(define piece?
  (lambda (dato) (if (or (equal? dato "red") (equal? dato "yellow")) #t #f)))


;;SELECTORES


;;MODIFICADORES


;;OTROS
