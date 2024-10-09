#lang racket
(require "TDA-player.rkt")
(require "TDA-piece.rkt")
(require "TDA-board.rkt")
(require "TDA-game.rkt")


;ejemplos de uso:

;player
(define p1 (player 1 "Juan" "red" 0 0 0 21))
(define p2 (player 2 "Juan" "yellow" 0 0 0 21))
(define p3 (player 1 "Mateo" "red" 10 5 2 21))
p1
p2
p3


;piece
(define red-piece (piece "red"))
(define yellow-piece (piece "yellow"))
red-piece
yellow-piece


;board
(define empty-board (board))
(define b0 (board))
(define tablero-vacio (board))
empty-board
b0
tablero-vacio


;board-can-play?
(define matriz1 '(("red" "yellow" "red" 0 0 0 0)
                  ("red" "red" "yellow" 0 0 0 0)
                  ("red" "yellow" "red" 0 0 0 0)
                  ("yellow" "red" "red" 0 0 0 0)
                  ("red" "yellow" "yellow" 0 0 0 "red")
                  ("red" "yellow" "red" 0 0 0 "yellow")))

(define matriz2 '(("red" "yellow" "red" "red" "yellow" "yellow" "red")
                  ("red" "red" "yellow" "red" "yellow" "red" "yellow")
                  ("red" "yellow" "red" "yellow" "red" "red" "yellow")
                  ("yellow" "red" "red" "yellow" "red" "yellow" "yellow")
                  ("red" "yellow" "yellow" "yellow" "red" "yellow" "red")
                  ("red" "yellow" "red" "yellow" "red" "yellow" "yellow")))
(board-can-play? matriz1)
(board-can-play? empty-board)
(board-can-play? matriz2)


;game
(define new-game (game p1 p2 empty-board 1))
new-game
