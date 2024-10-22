#lang racket
(require "TDA-player.rkt")
(require "TDA-piece.rkt")
(require "TDA-board.rkt")
(require "TDA-game.rkt")

(define p1 (player 1 "Mateo" "rojo" 0 0 0 21))
(define p2 (player 2 "Cristobal" "amarillo" 0 0 0 21))

(define empty-board (board))

(define g0 (game p1 p2 empty-board 1))
(define g1 (game-player-set-move g0 p1 3))
(define g2 (game-player-set-move g1 p2 2))
(define g3 (game-player-set-move g2 p1 3))
(define g4 (game-player-set-move g3 p2 3))
(define g5 (game-player-set-move g4 p1 4))
(define g6 (game-player-set-move g5 p2 5))
(define g7 (game-player-set-move g6 p1 2))
(define g8 (game-player-set-move g7 p2 4))
(define g9 (game-player-set-move g8 p1 2))
(define g10 (game-player-set-move g9 p2 2))