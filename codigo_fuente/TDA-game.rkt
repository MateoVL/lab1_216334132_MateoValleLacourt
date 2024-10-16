#lang racket
(require "TDA-player.rkt")
(require "TDA-board.rkt")

(provide game)
(provide game-get-p1)
(provide game-get-p2)
(provide game-history)
(provide game-is-draw?)
(provide game-get-current-player)
(provide game-set-end)
(provide game-player-set-move)
(provide game-get-board)

;;;TDA-game: Estuctura que representa un juego, con todas sus caracteristicas, como los jugadores, el tablero, y el turno actual. Representada como una lista.



 ;;;;;;;;;;;;;;;;;
 ; CONSTRUCTORES ;
 ;;;;;;;;;;;;;;;;;


; Descripción: funcion que crea una nueva partida.
; Dom: player1 (player) X player2 (player) X board (board) X current-turn (int)
; Rec: juego (game)
; Tipo recursión: No aplica

(define game
  (lambda (player1 player2 board current-turn) (list player1 player2 board current-turn (list))))




 ;;;;;;;;;;;;;;;
 ; PERTENENCIA ;
 ;;;;;;;;;;;;;;;




 ;;;;;;;;;;;;;;
 ; SELECTORES ;
 ;;;;;;;;;;;;;;


(define game-get-p1
  (lambda (game)
    (list-ref game 0)))

(define game-get-p2
  (lambda (game)
    (list-ref game 1)))


(define game-get-current-turn
  (lambda (game)
    (list-ref game 3)))



; Descripción: funcion que obtiene el jugador del turno actual.
; Dom: game (game)
; Rec: jugador del turno (player)
; Tipo recursión: No aplica
(define game-get-current-player
  (lambda (game)
    (if (equal? (game-get-current-turn game) 1) (game-get-p1 game) (game-get-p2 game))))

;ejemplo de uso: (game-get-current-player current-game)



; Descripción: funcion que entrega el tablero actual.
; Dom: game (game)
; Rec: jugador del turno (player)
; Tipo recursión: No aplica

(define game-get-board
  (lambda (game) (list-ref game 2)))

;ejemplo de uso: (game-get-board current-game)




 ;;;;;;;;;;;;;;;;;
 ;;MODIFICADORES ;
 ;;;;;;;;;;;;;;;;;


; Descripción: funcion que finaliza el juego, actualizando las estadisticas de los jugadores.
; Dom: game (game)
; Rec: juego terminado (game)
; Tipo recursión: Cola

(define game-set-end
  (lambda (game)
    (cond
      [(equal? (board-who-is-winner (game-get-board game)) 1) (define recursion-1
                                                                (lambda (game contador)
                                                                  (cond
                                                                    [(equal? contador 0) (recursion-1 (list-set game 0 (player-update-stats (list-ref game 0) "win")) (add1 contador))]
                                                                    [(equal? contador 1) (recursion-1 (list-set game 1 (player-update-stats (list-ref game 1) "loss")) (add1 contador))]
                                                                    [(> contador 1) game])))
                                                              (recursion-1 game 0)]
      [(equal? (board-who-is-winner (game-get-board game)) 2) (define recursion-2
                                                                (lambda (game contador)
                                                                  (cond
                                                                    [(equal? contador 0) (recursion-2 (list-set game 0 (player-update-stats (list-ref game 0) "loss")) (add1 contador))]
                                                                    [(equal? contador 1) (recursion-2 (list-set game 1 (player-update-stats (list-ref game 1) "win")) (add1 contador))]
                                                                    [(> contador 1) game])))
                                                              (recursion-2 game 0)]
      [(equal? (board-who-is-winner (game-get-board game)) 0) (define recursion-0
                                                                (lambda (game contador)
                                                                  (cond
                                                                    [(equal? contador 0) (recursion-0 (list-set game 0 (player-update-stats (list-ref game 0) "draw")) (add1 contador))]
                                                                    [(equal? contador 1) (recursion-0 (list-set game 1 (player-update-stats (list-ref game 1) "draw")) (add1 contador))]
                                                                    [(> contador 1) game])))
                                                              (recursion-0 game 0)])))



; Descripción: funcion que realiza un movimiento.
; Dom: game (game) X player (player) X column (int)
; Rec: juego actualizado (game)
; Tipo recursión: No aplica
; REGLAS: verificar que el turno sea correcto, actualizar el estado del juego despues de realizar el movimiento: colocar pieza, cambiar turno, disminuir la cant de fichas, actualizar el historial de movimientos. verificar si hay un ganador o si hay empate, si se termina el jueg: actualizar las estadisticas de los 2 jugadores.
(define game-player-set-move
  (lambda (juego player column)
    (game-set-history (game (game-get-p1 juego) (game-get-p2 juego) (board-set-play-piece (game-get-board juego) column (player-get-color player)) (add1 (game-get-current-turn juego))) juego (cons column (player-get-color player)))   ))

;ejemplo de uso:(define updated-game (game-player-set-move current-game p1 3))

(define game-set-history
  (lambda (juego juego2 move)
    (list-set juego 4 (cons move (list-ref juego2 4)))))


 ;;;;;;;;;
 ; OTROS ;
 ;;;;;;;;;

; Descripción: funcion que genera un historial de movimientos de la partida.
; Dom: game (game)
; Rec: movimientos (list de pares)
; Tipo recursión: No aplica
;POR DEFINIR
(define game-history
  (lambda (game)
    (reverse (list-ref game 4))))



; Descripción: funcion que verifica si el estado del juego es empate. Tablero lleno o jugadores sin fichas.
; Dom: game (game)
; Rec: empate (boolean)
; Tipo recursión: No aplica

(define game-is-draw?
  (lambda (game)
    (if (and (or(not (board-can-play? (game-get-board game))) (and (equal? (player-get-remaining-pieces (game-get-p1 game)) 0) (equal? (player-get-remaining-pieces (game-get-p2 game)) 0)))
         (equal? (board-who-is-winner (game-get-board game)) 0))
        #t
        #f)))


