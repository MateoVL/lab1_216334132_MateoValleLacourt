#lang racket
(require "TDA-player_21633413_Mateo_ValleLacourt.rkt")
(require "TDA-piece_21633413_Mateo_ValleLacourt.rkt")
(require "TDA-board_21633413_Mateo_ValleLacourt.rkt")

(provide game)
(provide game-with-history)
(provide game-get-p1)
(provide game-get-p2)
(provide game-history)
(provide game-is-draw?)
(provide game-get-current-player)
(provide game-get-current-turn)
(provide game-get-board)
(provide game-set-end)
(provide game-player-set-move)
(provide jugada-p1)
(provide jugada-p2)


;;;TDA-game: Estuctura que representa un juego, con todas sus caracteristicas, como los jugadores, el tablero, y el turno actual (entre 1 y 2, referenciando a jugador 1 y 2 del juego actual).
;Ademas agrega una lista que representa un historial. El TDA es representado como una lista.



 ;;;;;;;;;;;;;;;;;
 ; CONSTRUCTORES ;
 ;;;;;;;;;;;;;;;;;


; RF11 - TDA Game - constructor
; Descripción: funcion que crea una nueva partida.
; Dom: player1 (player) X player2 (player) X board (board) X current-turn (int)
; Rec: juego (game)
; Tipo recursión: No aplica

(define game
  (lambda (player1 player2 board current-turn)
    (list player1 player2 (board-with-players board player1 player2) current-turn (list))))



; Descripción: funcion que actualiza el historial de un juego dado su estado anterior.
; Dom: juego (game) X player (player) X move (par: (columna. color))
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



; RF16 - TDA Game - selector - board-get-state
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



; RF15 - TDA Game - selector - getCurrentPlayer
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


; Descripción: funcion que realiza la jugada de p1.
; Dom: juego (game) X player (player) X column (int)
; Rec: juego actualizado con jugada de p1 (game)
; Tipo recursión: No aplica

(define jugada-p1 (lambda (juego player column)
                    (game-with-history (game (player-set-sub1-fichas (game-get-p1 juego))
                                             (game-get-p2 juego)
                                             (board-set-play-piece (game-get-board juego) column (player-get-piece player))
                                             (add1 (game-get-current-turn juego)))
                                       juego
                                       (cons column (piece-get-name (player-get-piece player))))))



; Descripción: funcion que realiza la jugada de p2.
; Dom: juego (game) X player (player) X column (int)
; Rec: juego actualizado con jugada de p2 (game)
; Tipo recursión: No aplica

(define jugada-p2 (lambda (juego player column)
                    (game-with-history (game (game-get-p1 juego)
                                             (player-set-sub1-fichas (game-get-p2 juego))
                                             (board-set-play-piece (game-get-board juego) column (player-get-piece player))
                                             (sub1 (game-get-current-turn juego)))
                                       juego
                                       (cons column (piece-get-name (player-get-piece player))))))



; RF17 - TDA Game - modificador - game-set-end
; Descripción: funcion que finaliza el juego, actualizando las estadisticas de los jugadores.
; Dom: Game (game)
; Rec: juego terminado (game)
; Tipo recursión: No aplica

(define game-set-end
  (lambda (Game)
    
    (cond
      [(equal? (board-who-is-winner (game-get-board Game)) 1)
       (game-with-history (game
                          (player-update-stats (game-get-p1 Game) "win")
                          (player-update-stats (game-get-p2 Game) "loss")
                          (game-get-board Game)
                          (game-get-current-turn Game))
                         Game
                         null)]

      [(equal? (board-who-is-winner (game-get-board Game)) 2)
       (game-with-history (game
                          (player-update-stats (game-get-p1 Game) "loss")
                          (player-update-stats (game-get-p2 Game) "win")
                          (game-get-board Game)
                          (game-get-current-turn Game))
                         Game
                         null)]

      [(equal? (board-who-is-winner (game-get-board Game)) 0)
       (game-with-history (game
                          (player-update-stats (game-get-p1 Game) "draw")
                          (player-update-stats (game-get-p2 Game) "draw")
                          (game-get-board Game)
                          (game-get-current-turn Game))
                         Game
                         null)])))



; RF18 - TDA Game - modificador - realizarMovimiento
; Descripción: funcion que realiza un movimiento.
; Dom: Game (game) X player (player) X column (int)
; Rec: juego actualizado (game)
; Tipo recursión: No aplica

(define game-player-set-move
  (lambda (Game player column)
    (cond
      [(equal? (board-set-play-piece (game-get-board Game) column (player-get-piece player)) #f) Game]  ;si la jugada es imposible devolver el juego sin cambios
      [(and (equal? (game-get-current-turn Game) 1)
            (equal? (player-get-id player) (player-get-id (game-get-p1 Game))))  ;si el turno es de p1 y juega p1...

       (if (or (game-is-draw? (jugada-p1 Game player column))
               (equal? (board-who-is-winner (game-get-board (jugada-p1 Game player column))) 1))  ;si es empate o victoria...
           (game-set-end (jugada-p1 Game player column))             ;declarar fin
           (jugada-p1 Game player column))]                          ;sino, devolver nueva jugada

      [(and (equal? (game-get-current-turn Game) 2)
            (equal? (player-get-id player) (player-get-id (game-get-p2 Game)))) ;si el turno es de p2 y juega p2...

       (if (or (game-is-draw? (jugada-p2 Game player column))
               (equal? (board-who-is-winner (game-get-board (jugada-p2 Game player column))) 2))   ;si es empate o victoria...     
           (game-set-end (jugada-p2 Game player column))             ;declarar fin    
           (jugada-p2 Game player column))]                          ;sino, devolver nueva jugada

      [else Game])))  ;si el turno es incorrecto devuelve el juego sin cambios




 ;;;;;;;;;
 ; OTROS ;
 ;;;;;;;;;


; RF12 - TDA Game - otros - history
; Descripción: funcion que genera un historial de movimientos de la partida.
; Dom: game (game)
; Rec: historial (list de pares)
; Tipo recursión: No aplica

(define game-history
  (lambda (game)
    (list-ref game 4)))



; RF13 - TDA Game - otros - esEmpate?
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
