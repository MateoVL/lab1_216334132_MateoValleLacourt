#lang racket
(require "TDA-player.rkt")
(require "TDA-piece.rkt")
(require "TDA-board.rkt")

(provide game)
(provide game-get-p1)
(provide game-get-p2)
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
  (lambda (player1 player2 board current-turn) (list player1 player2 (board-2.0 board player1 player2) current-turn (list))))



; Descripción: funcion que actualiza el historial de un juego dado su estado anterior.
; Dom: game (game) X player (player) X column (int)
; Rec: juego actualizado (game)
; Tipo recursión: No aplica

(define game-with-history
  (lambda (juego juego-previo move)
    (if (equal? move null)
        (list-set juego 4 (list-ref juego-previo 4))
        (list-set juego 4 (reverse (cons move (reverse (list-ref juego-previo 4))))))))




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
 ; MODIFICADORES ;
 ;;;;;;;;;;;;;;;;;


; Descripción: funcion que finaliza el juego, actualizando las estadisticas de los jugadores.
; Dom: game (game)
; Rec: juego terminado (game)
; Tipo recursión: No aplica

(define game-set-end
  (lambda (juego)
    
    (cond
      [(equal? (board-who-is-winner (game-get-board juego)) 1)
       (game-with-history (game
                          (player-update-stats (game-get-p1 juego) "win")
                          (player-update-stats (game-get-p2 juego) "loss")
                          (game-get-board juego)
                          (game-get-current-turn juego))
                         juego
                         null)]

      [(equal? (board-who-is-winner (game-get-board juego)) 2)
       (game-with-history (game
                          (player-update-stats (game-get-p1 juego) "loss")
                          (player-update-stats (game-get-p2 juego) "win")
                          (game-get-board juego)
                          (game-get-current-turn juego))
                         juego
                         null)]

      [(equal? (board-who-is-winner (game-get-board juego)) 0)
       (game-with-history (game
                          (player-update-stats (game-get-p1 juego) "draw")
                          (player-update-stats (game-get-p2 juego) "draw")
                          (game-get-board juego)
                          (game-get-current-turn juego))
                         juego
                         null)])))



; Descripción: funcion que realiza un movimiento.
; Dom: game (game) X player (player) X column (int)
; Rec: juego actualizado (game)
; Tipo recursión: No aplica

(define game-player-set-move
  (lambda (juego player column)
    (cond
      [(equal? (board-set-play-piece (game-get-board juego) column (player-get-piece player)) -1) juego]                   ;si la jugada es imposible devolver el juego sin cambios
      [(and (equal? (game-get-current-turn juego) 1) (equal? (player-get-id player) (player-get-id (game-get-p1 juego))))  ;si el turno es correcto...
       (define jugada-p1 (game-with-history (game                                                                          ;crear el nuevo estado de juego
                                             (player-set-sub1-fichas (game-get-p1 juego))
                                             (game-get-p2 juego)
                                             (board-set-play-piece (game-get-board juego) column (player-get-piece player))
                                             (add1 (game-get-current-turn juego)))
                                            juego
                                            (cons column (piece-get-name (player-get-piece player)))))

       (if (game-is-draw? jugada-p1)            ;si es empate...
           (game-set-end jugada-p1)             ;declarar empate
           (if (equal? (board-who-is-winner (game-get-board jugada-p1)) 1)     ;sino, si es victoria...
               (game-set-end jugada-p1)         ;declarar victoria
               jugada-p1))]                     ;sino, devolver neva jugada



      
      [(and (equal? (game-get-current-turn juego) 2) (equal? (player-get-id player) (player-get-id (game-get-p2 juego))))
       (define jugada-p2 (game-with-history (game
                                             (game-get-p1 juego)
                                             (player-set-sub1-fichas (game-get-p2 juego))
                                             (board-set-play-piece (game-get-board juego) column (player-get-piece player))
                                             (sub1 (game-get-current-turn juego)))
                                            juego
                                            (cons column (piece-get-name (player-get-piece player)))))
       
       (if (game-is-draw? jugada-p2)         
           (game-set-end jugada-p2)           
           (if (equal? (board-who-is-winner (game-get-board jugada-p2)) 2)     
               (game-set-end jugada-p2)      
               jugada-p2))]

      [else juego])))  ;si el turno es incorrecto devuelve el juego sin cambios




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

