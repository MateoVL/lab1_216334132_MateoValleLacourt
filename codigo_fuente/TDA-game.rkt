#lang racket
(require "TDA-player.rkt")
(require "TDA-piece.rkt")
(require "TDA-board.rkt")

(provide game)
(provide game-history)
(provide game-is-draw?)
(provide game-get-current-player)
(provide game-get-board)
(provide game-set-end)
(provide game-player-set-move)


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


; Descripción: funcion que entrega el jugador 1 del juego.
; Dom: game (game)
; Rec: jugador 1 (player)
; Tipo recursión: No aplica

(define game-get-p1
  (lambda (game) (list-ref game 0)))



; Descripción: funcion que entrega el jugador 2 del juego.
; Dom: game (game)
; Rec: jugador 2 (player)
; Tipo recursión: No aplica

(define game-get-p2
  (lambda (game) (list-ref game 1)))



; Descripción: funcion que entrega el tablero actual.
; Dom: game (game)
; Rec: estado del tablero del juego actual (board)
; Tipo recursión: No aplica

(define game-get-board
  (lambda (game) (list-ref game 2)))



; Descripción: funcion que entrega el turno actual del juego.
; Dom: game (game)
; Rec: turno actual (int)
; Tipo recursión: No aplica

(define game-get-current-turn
  (lambda (game) (list-ref game 3)))



; Descripción: funcion que obtiene el jugador del turno actual.
; Dom: game (game)
; Rec: jugador del turno actual (player)
; Tipo recursión: No aplica

(define game-get-current-player
  (lambda (game)
    (if (equal? (game-get-current-turn game) 1)
        (game-get-p1 game)
        (game-get-p2 game))))




 ;;;;;;;;;;;;;;;;;
 ;;MODIFICADORES ;
 ;;;;;;;;;;;;;;;;;


; Descripción: funcion que finaliza el juego, actualizando las estadisticas de los jugadores.
; Dom: game (game)
; Rec: juego terminado (game)
; Tipo recursión: No aplica

(define game-set-end
  (lambda (juego)
    (cond
      ; Descripción: recursion-1 2 y 3 hacen practicamente lo mismo.
      ; Dom: game (game)
      ; Rec: juego terminado (game)
      ; Tipo recursión: Cola
      [(equal? (board-who-is-winner (game-get-board juego)) 1)
       (game-set-history (game (player-update-stats (game-get-p1 juego) "win") (player-update-stats (game-get-p2 juego) "loss") (game-get-board juego) (game-get-current-turn juego)) juego null)]



       #|(define recursion-1
                                                                (lambda (game contador)
                                                                  (cond
                                                                    [(equal? contador 0) (recursion-1 (list-set game 0 (player-update-stats (list-ref game 0) "win")) (add1 contador))]
                                                                    [(equal? contador 1) (recursion-1 (list-set game 1 (player-update-stats (list-ref game 1) "loss")) (add1 contador))]
                                                                    [(> contador 1) game])))
                                                              (recursion-1 game 0)]|#

      [(equal? (board-who-is-winner (game-get-board game)) 2)
       (game-set-history (game (player-update-stats (game-get-p1 game) "loss") (player-update-stats (game-get-p2 game) "win") (game-get-board game) (game-get-current-turn game)) juego null)]


       #|(define recursion-2
                                                                (lambda (game contador)
                                                                  (cond
                                                                    [(equal? contador 0) (recursion-2 (list-set game 0 (player-update-stats (list-ref game 0) "loss")) (add1 contador))]
                                                                    [(equal? contador 1) (recursion-2 (list-set game 1 (player-update-stats (list-ref game 1) "win")) (add1 contador))]
                                                                    [(> contador 1) game])))
                                                              (recursion-2 game 0)]|#

      [(equal? (board-who-is-winner (game-get-board game)) 0)
       (game-set-history (game (player-update-stats (game-get-p1 game) "draw") (player-update-stats (game-get-p2 game) "draw") (game-get-board game) (game-get-current-turn game)) juego null)])))


       #|(define recursion-0
                                                                (lambda (game contador)
                                                                  (cond
                                                                    [(equal? contador 0) (recursion-0 (list-set game 0 (player-update-stats (list-ref game 0) "draw")) (add1 contador))]
                                                                    [(equal? contador 1) (recursion-0 (list-set game 1 (player-update-stats (list-ref game 1) "draw")) (add1 contador))]
                                                                    [(> contador 1) game])))
                                                              (recursion-0 game 0)])))|#



; Descripción: funcion que realiza un movimiento.
; Dom: game (game) X player (player) X column (int)
; Rec: juego actualizado (game)
; Tipo recursión: No aplica

(define game-player-set-move
  (lambda (juego player column)
    (cond

      [(and (equal? (game-get-current-turn juego) 1) (equal? (player-get-id player) (player-get-id (game-get-p1 juego))))
       (define jugada-p1 (game-set-history (game
                                         (player-set-sub1-fichas (game-get-p1 juego))
                                         (game-get-p2 juego)
                                         (board-set-play-piece (game-get-board juego) column (piece-get-piece (piece (player-get-color player))))
                                         (add1 (game-get-current-turn juego)))
                                        juego
                                        (cons column (player-get-color player))))

       (if (equal? (game-get-board jugada-p1) -1)
           (display "Movimiento no disponible")     ;caso jugada no disponible
           (if (game-is-draw? jugada-p1)            ;sino, si es empate?
               (game-set-end jugada-p1)           ;declarar empate
               (if (equal? (board-who-is-winner (game-get-board jugada-p1)) 1)     ;es victoria?
                   (game-set-end jugada-p1)      ;declarar victoria
                   jugada-p1)))]



      
      [(and (equal? (game-get-current-turn juego) 2) (equal? (player-get-id player) (player-get-id (game-get-p2 juego))))
       (define jugada-p2 (game-set-history (game
                                            (game-get-p1 juego)
                                            (player-set-sub1-fichas (game-get-p2 juego))
                                            (board-set-play-piece (game-get-board juego) column (piece-get-piece (piece (player-get-color player))))
                                            (sub1 (game-get-current-turn juego)))
                                           juego
                                           (cons column (player-get-color player))))

       (if (equal? (game-get-board jugada-p2) -1)
           (display "Movimiento no disponible")     ;caso jugada no disponible
           (if (game-is-draw? jugada-p2)            ;sino, si es empate?
               (game-set-end jugada-p2)           ;declarar empate
               (if (equal? (board-who-is-winner (game-get-board jugada-p2)) 2)     ;es victoria?
                   (game-set-end jugada-p2)      ;declarar victoria
                   jugada-p2)))]
      )))



; Descripción: funcion que actualiza el historial de un juego dado su estado anterior.
; Dom: game (game) X player (player) X column (int)
; Rec: juego actualizado (game)
; Tipo recursión: No aplica

(define game-set-history
  (lambda (juego juego-previo move)
    (if (equal? move null)
        (list-set juego 4 (list-ref juego-previo 4))
        (list-set juego 4 (reverse (cons move (reverse (list-ref juego-previo 4))))))))




 ;;;;;;;;;
 ; OTROS ;
 ;;;;;;;;;

; Descripción: funcion que genera un historial de movimientos de la partida.
; Dom: game (game)
; Rec: movimientos (list de pares)
; Tipo recursión: No aplica

(define game-history
  (lambda (game)
    (list-ref game 4)))



; Descripción: funcion que verifica si el estado del juego es empate. Tablero lleno o jugadores sin fichas.
; Dom: game (game)
; Rec: empate (boolean)
; Tipo recursión: No aplica

(define game-is-draw?
  (lambda (game)
    (if (and
         (or (not (board-can-play? (game-get-board game)))
             (and (equal? (player-get-remaining-pieces (game-get-p1 game)) 0)
                  (equal? (player-get-remaining-pieces (game-get-p2 game)) 0)))
         (equal? (board-who-is-winner (game-get-board game)) 0))
        #t
        #f)))

