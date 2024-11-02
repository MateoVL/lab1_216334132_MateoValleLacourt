#lang racket
(require "TDA-piece_21633413_ValleLacourt.rkt")

(provide player)
(provide player-update-stats)
(provide player-get-remaining-pieces)
(provide player-get-piece)
(provide player-set-sub1-fichas)
(provide player-get-id)
(provide player-set-add1-wins)
(provide player-set-add1-losses)
(provide player-set-add1-draws)
(provide player-set-sub1-fichas)



;;;TDA player: La estructura de player se conforma por una lista con los elementos que identifican a un jugador, como su id, nombre, la ficha con la que juega, victorias, derrotas, empates y piezas restantes.
;Implementado con listas.



 ;;;;;;;;;;;;;;;;;
 ; CONSTRUCTORES ;
 ;;;;;;;;;;;;;;;;;


; RF02 - TDA Player - constructor
; Descripción: funcion que permite crear un jugador.
; Dom: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining-pieces (int)
; Rec: jugador (player)
; Tipo recursión: No aplica

(define player
  (lambda (id name color wins losses draws remaining-pieces)
    (list id name (piece color) wins losses draws remaining-pieces)))




 ;;;;;;;;;;;;;;;
 ; PERTENENCIA ;
 ;;;;;;;;;;;;;;;



 ;;;;;;;;;;;;;;
 ; SELECTORES ;
 ;;;;;;;;;;;;;;


; Descripción: funcion que entrega el id de un jugador.
; Dom: player (player)
; Rec: id de jugador (int)
; Tipo recursión: No aplica

(define player-get-id
  (lambda (player)
    (list-ref player 0)))



; Descripción: funcion que entrega la representacion de ficha de un jugador.
; Dom: player (player)
; Rec: representacion ficha (string)
; Tipo recursión: No aplica

(define player-get-piece
  (lambda (player)
    (list-ref player 2)))



; Descripción: funcion que entrega las victorias de un jugador.
; Dom: player (player)
; Rec: cantidad de victorias (int)
; Tipo recursión: No aplica

(define player-get-wins
  (lambda (player)
    (list-ref player 3)))



; Descripción: funcion que entrega las derrotas de un jugador.
; Dom: player (player)
; Rec: cantidad de derrotas (int)
; Tipo recursión: No aplica

(define player-get-losses
  (lambda (player)
    (list-ref player 4)))



; Descripción: funcion que entrega los empates de un jugador.
; Dom: player (player)
; Rec: cantidad de empates (int)
; Tipo recursión: No aplica

(define player-get-draws
  (lambda (player)
    (list-ref player 5)))



; Descripción: funcion que entrega la cantidad de piezas disponibles de un jugador.
; Dom: player (player)
; Rec: cantidad de piezas (int)
; Tipo recursión: No aplica

(define player-get-remaining-pieces
  (lambda (player)
    (last player)))




 ;;;;;;;;;;;;;;;;;
 ;;MODIFICADORES ;
 ;;;;;;;;;;;;;;;;;


; Descripción: funcion que aumenta la cantidad de victorias de un jugador por una unidad.
; Dom: player (player)
; Rec: jugador con victorias actualizadas (player)
; Tipo recursión: No aplica

(define player-set-add1-wins
  (lambda (player)
    (list-set player 3 (add1 (player-get-wins player)))))



; Descripción: funcion que aumenta la cantidad de derrotas de un jugador por una unidad.
; Dom: player (player)
; Rec: jugador con derrotas actualizadas (player)
; Tipo recursión: No aplica

(define player-set-add1-losses
  (lambda (player)
    (list-set player 4 (add1 (player-get-losses player)))))



; Descripción: funcion que aumenta la cantidad de empates de un jugador por una unidad.
; Dom: player (player)
; Rec: jugador con empates actualizados (player)
; Tipo recursión: No aplica

(define player-set-add1-draws
  (lambda (player)
    (list-set player 5 (add1 (player-get-draws player)))))



; Descripción: funcion que resta la cantidad de fichas de un jugador por una unidad.
; Dom: player (player)
; Rec: jugador con fichas actualizadas (player)
; Tipo recursión: No aplica

(define player-set-sub1-fichas
  (lambda (player)
    (list-set player 6 (sub1 (player-get-remaining-pieces player)))))




 ;;;;;;;;;
 ; OTROS ;
 ;;;;;;;;;


; RF14 - TDA Player - otros - actualizarEstadisticas
; Descripción: funcion que actualiza las estadisticas del jugador despues de un juego (victoria, derrota o empate).
; Dom: player (player) X result (string: "win" | "loss" | "draw")
; Rec: player actualizado (player)
; Tipo recursión: No aplica

(define player-update-stats
  (lambda (player result)
    (cond
      [(equal? result "win") (player-set-add1-wins player)]
      [(equal? result "loss") (player-set-add1-losses player)]
      [(equal? result "draw") (player-set-add1-draws player)])))
