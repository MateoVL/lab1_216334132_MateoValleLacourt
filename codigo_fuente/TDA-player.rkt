#lang racket
(provide player)
(provide player-update-stats)
(provide player-get-remaining-pieces)
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
  (lambda (player) (list-ref player 2)))



(define player-get-remaining-pieces
  (lambda (player)
    (last player)))


(define player-get-wins
  (lambda (player)
    (list-ref player 3)))


(define player-get-losses
  (lambda (player)
    (list-ref player 4)))


(define player-get-draws
  (lambda (player)
    (list-ref player 5)))



;;MODIFICADORES

(define player-set-wins
  (lambda (player elemento)
    (list-set player 3 elemento)))


(define player-set-losses
  (lambda (player elemento)
    (list-set player 4 elemento)))


(define player-set-draws
  (lambda (player elemento)
    (list-set player 5 elemento)))


;;OTROS


; Descripción: funcion que actualiza las estadisticas del jugador despues de un juego (victoria, derrota o empate) y retorna booleano dependiendo si es empate o no.
; Dom: player (player) X result (string: "win", "loss", o "draw")
; Rec: player actualizado (player)
; Tipo recursión: No aplica

(define player-update-stats
  (lambda (player result)
    (cond
      [(equal? result "win") (cons #f (player-set-wins player (add1 (player-get-wins player))))]
      [(equal? result "loss") (cons #f (player-set-losses player (add1 (player-get-losses player))))]
      [(equal? result "draw") (cons #t (player-set-draws player (add1 (player-get-draws player))))])))


