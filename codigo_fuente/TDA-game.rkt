#lang racket
(provide game)


;;;TDA-game: Estuctura que representa un juego, con todas sus caracteristicas, como los jugadores, el tablero, y el turno actual. Representada como una lista.


;;CONSTRUCTORES


; Descripción: funcion que crea una nueva partida.
; Dom: player1 (player) X player2 (player) X board (board) X current-turn (int)
; Rec: juego (game)
; Tipo recursión: No aplica

(define game
  (lambda (player1 player2 board current-turn) (list player1 player2 board current-turn)))



;;PERTENENCIA


;;SELECTORES


; Descripción: funcion que obtiene el jugador del turno actual.
; Dom: game (game)
; Rec: jugador del turno (player)
; Tipo recursión: No aplica
;(define game-get-current-player
;  (lambda game player #|TAREA|#))

;ejemplo de uso: (game-get-current-player current-game)



; Descripción: funcion que entrega el tablero actual.
; Dom: game (game)
; Rec: jugador del turno (player)
; Tipo recursión: No aplica
;(define game-get-board
;  (lambda game board #|TAREA|#))

;ejemplo de uso: (game-get-board current-game)



;;MODIFICADORES


; Descripción: funcion que finaliza el juego, actualizando las estadisticas de los jugadores.
; Dom: game (game)
; Rec: juego terminado (game)
; Tipo recursión: No aplica
;(define game-set-end
;  (lambda (game) game #|TAREA|#))

;ejemplo de uso: (define ended-game (game-set-end current-game))



; Descripción: funcion que realiza un movimiento.
; Dom: game (game) X player (player) X column (int)
; Rec: juego actualizado (game)
; Tipo recursión: No aplica
; REGLAS: verificar que el turno sea correcto, actualizar el estado del juego despues de realizar el movimiento: colocar pieza, cambiar turno, disminuir la cant de fichas, actualizar el historial de movimientos. verificar si hay un ganador o si hay empate, si se termina el jueg: actualizar las estadisticas de los 2 jugadores.
;(define game-player-set-move
;  (lambda (game player column) game #|TAREA|#))

;ejemplo de uso: (define updated-game (game-player-set-move current-game p1 3))



;;OTROS


; Descripción: funcion que genera un historial de movimientos de la partida.
; Dom: game (game)
; Rec: movimientos (list de pares)
; Tipo recursión: No aplica
; IDEA: resolver de manera declarativa
;(define game-history
;  (lambda game lista de pares #|TAREA|#))

;ejemplo de uso: (game-history updated-game)



; Descripción: funcion que verifica si el estado del juego es empate. Tablero lleno o jugadores sin fichas.
; Dom: game (game)
; Rec: empate (boolean)
; Tipo recursión: No aplica
;(define game-is-draw?
;  (lambda game boolean #|TAREA|#))

;ejemplo de uso: (game-is-draw? current-game)



