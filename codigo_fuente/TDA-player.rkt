#lang racket
(provide player)
(provide player-get-color)

;TDA player: La estructura de player se conforma por una lista con los elementos que identifican a un jugador, como su id, nombre, color, victorias, derrotas, empates y piezas restantes.


;CONSTRUCTORES


; Descripción: funcion que permite crear un jugador.
; Dom: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining-pieces (int)
; Rec: jugador (player)
; Tipo recursión: No aplica

(define player
  (lambda (id name color wins losses draws remaining-pieces) (list id name color wins losses draws remaining-pieces)))



;;PERTENENCIA


;;SELECTORES


(define player-get-color
  (lambda player (list-ref player 2)))



;;MODIFICADORES


;;OTROS


; Descripción: funcion que actualiza las estadisticas del jugador despues de un juego (victoria, derrota o empate) y retorna booleano dependiendo si es empate o no.
; Dom: player (player) X result (string: "win", "loss", o "draw")
; Rec: empate (boolean)
; Tipo recursión: No aplica

;(define player-update-stats
;  (lambda (player result) booleano))

;ejemplo de uso: (game-is-draw? current-game)

