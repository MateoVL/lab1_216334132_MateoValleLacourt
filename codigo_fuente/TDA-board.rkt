#lang racket
(provide board)
(provide board-can-play?)

;;;TDA board: Estructura que representa un tablero 6x7 de conecta 4 en base de una matriz, hecha con una lista de listas.


;;CONSTRUCTORES


; Descripción: funcion que crea un tablero de conecta 4.
; Dom: sin parametros de entrada
; Rec: tablero vacio (board)
; Tipo recursión: No aplica
; TAREA: definir que es vacio

(define (board) '((0 0 0 0 0 0 0)
                 (0 0 0 0 0 0 0)
                 (0 0 0 0 0 0 0)
                 (0 0 0 0 0 0 0)
                 (0 0 0 0 0 0 0)
                 (0 0 0 0 0 0 0)))



;;PERTENENCIA


;;SELECTORES


;;MODIFICADORES


; Descripción: funcion que permite realizar una jugada en el tablero.
; Dom: board (board) X column (int) X piece (piece)
; Rec: tablero actualizado (board)
; Tipo recursión: No aplica
; IDEA: resolver de manera declarativa

;(define board-set-play-piece
;  (lambda (board column piece) #|trabajar|#))

;ejmplo de uso: (define updated-board (board-set-play-piece empty-board 3 red-piece))



;;OTROS


; Descripción: funcion que permite verificar si se pueden hacer mas jugadas en el tablero, true: si se puede, false: no se puede.
; Dom: board (board)
; Rec: se puede jugar? (boolean)
; Tipo recursión: No aplica

(define board-can-play?
  (lambda (board) (list? (member 0 (first board)))))



; Descripción: funcion que permite verificar si algun jugador ha ganado verticalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Natural
;(define board-check-vertical-win
;  (lambda board int #|trabajar|#))

;ejemplo: (board-check-vertical-win updated-board)



; Descripción: funcion que permite verificar si algun jugador ha ganado horizontalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador horizontal.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Natural
;(define board-check-horizontal-win
;  (lambda board int #|trabajar|#))

;ejemplo de uso: (board-check-horizontal-win updated-board)



; Descripción: funcion que permite verificar si algun jugador ha ganado diagonalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador diagonal.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Natural o cola
;(define board-check-diagonal-win
;  (lambda board int #|trabajar|#))

;ejemplo de uso: (board-check-diagonal-win updated-board)



; Descripción: funcion que verifica el estado del tablero y entregar el posible ganador.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: No aplica
; IDEA: Realizar de forma declarativa.
;(define board-who-is-winner
;  (lambda board int #|trabajar|#))

;ejemplo de uso: (board-who-is-winner updated-board)


