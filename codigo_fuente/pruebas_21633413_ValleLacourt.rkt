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
;p1
;p2
;p3



;piece
;red-piece
;yellow-piece



;board
(define empty-board (board))
(define b0 (board))
(define tablero-vacio (board))
;empty-board
;b0
;tablero-vacio



;board-can-play?
(define matriz1 '(("red"    "yellow" "red"    0 0 0 0)
                  ("red"    "red"    "yellow" 0 0 0 0)
                  ("red"    "yellow" "red"    0 0 0 0)
                  ("yellow" "yellow" "red"    0 0 0 0)
                  ("red"    "yellow" "yellow" 0 0 0 "red")
                  ("red"    "yellow" "red"    0 0 0 "yellow")))

(define matriz2 '(("red"    "yellow" "yellow" "red"    "yellow" "yellow" "red")
                  ("red"    "red"    "yellow" "red"    "yellow" "red"    "red")
                  ("yellow" "yellow" "red"    "yellow" "red"    "red"    "yellow")
                  ("yellow" "red"    "red"    "yellow" "red"    "yellow" "yellow")
                  ("red"    "yellow" "red"    "yellow" "yellow" "yellow" "red")
                  ("yellow" "yellow" "yellow" "red"    "red"    "red"    "yellow")))
(define matriz3 '((0 "red" 0     0     0     0 0)
                  (0 0     "red" 0     0     0 0)
                  (0 0     0     "red" 0     0 0)
                  (0 0     0     0     "red" 0 0)
                  (0 0     0     0     0     0 0)
                  (0 0     0     0     0     0 0)))
(define matriz4 '((1 1 1 1 0 1 1)
                  (0 0 0 0 0 0 0)
                  (0 0 0 0 0 0 0)
                  (0 0 0 0 0 0 0)
                  (0 0 0 0 0 0 0)
                  (0 0 0 0 0 0 0)))
;(board-can-play? matriz1)
;(board-can-play? empty-board)
;(board-can-play? matriz2)



;board-set-play-piece
#|(define b1 (board-set-play-piece b0 6 red-piece))
(define b2 (board-set-play-piece b1 6 yellow-piece))
(define b3 (board-set-play-piece b2 6 red-piece))
(define b4 (board-set-play-piece b3 6 yellow-piece))
(define b5 (board-set-play-piece b4 6 yellow-piece))
(define b6 (board-set-play-piece b5 6 yellow-piece))
(define b7 (board-set-play-piece b6 6 yellow-piece))
b1
b2
b3
b4
b5
b6
b7|#



;board-check-vertical-win
;(board-check-vertical-win matriz1)
;(board-check-vertical-win matriz2)
;(board-check-vertical-win matriz3)



;board-check-horizontal-win
;(board-check-horizontal-win matriz1)
;(board-check-horizontal-win matriz2)
;(board-check-horizontal-win matriz3)



;board-check-diagonal-win
;(board-check-diagonal-win matriz1)
;(board-check-diagonal-win matriz2)
;(board-check-diagonal-win matriz3)



;board-who-is-winner
;(board-who-is-winner matriz1)
;(board-who-is-winner matriz2)
;(board-who-is-winner matriz3)



;game
(define new-game (game p1 p2 empty-board 1))
;(define updated-game (game p1 p3 matriz1 2))
;(define ug2 (game p1 p2 matriz3 1))
;(define ug3 (game p2 p3 matriz4 2))
;new-game
;updated-game
;ug2



;game-history
;(game-history new-game)



;game-is-draw?
;(game-is-draw? ug3)



;updated-player
;(define updated-player (player-update-stats p1 "win"))



;game-get-current-player
;(game-get-current-player new-game)


;(define ended-game (game-set-end ug2))
(define ug1 (game-player-set-move new-game p1 3))
(define ug2 (game-player-set-move ug1 p2 4))
(define ug3 (game-player-set-move ug2 p1 4))

;(game-set-history ug1 (cons 5 6))


