#lang racket
(require "TDA-player.rkt")
(require "TDA-piece.rkt")
(require "TDA-board.rkt")
(require "TDA-game.rkt")


;3 ejemplos de uso de cada funcion de los requisitos funcionales:

;RF2: player
(define p1 (player 1 "Juan" "red" 0 0 0 21))
(define p2 (player 2 "Juan" "yellow" 0 0 0 21))
(define p3 (player 1 "Mateo" "purple" 10 5 2 21))
(display "\nRF2: player\n")
p1
p2
p3


;RF3: piece
(define red-piece (piece "red"))
(define yellow-piece (piece "yellow"))
(define purple-piece (piece "purple"))
(display "\nRF3: piece\n")
red-piece
yellow-piece
purple-piece



;RF4: board
(define empty-board (board))
(define b0 (board))
(define tablero-vacio (board))
(display "\nRF4: board\n")
empty-board
b0
tablero-vacio



;tableros de prueba
(define tablero-1 '((("(R)" "(R)" "(A)" "(A)" "(R)" "(A)" "(A)")
                     ("(A)" "(A)" "(R)" "(A)" "(R)" "(A)" "(R)")
                     ("(A)" "(R)" "(R)" "(A)" "(A)" "(A)" "(R)")
                     ("(R)" "(R)" "(A)" "(R)" "(R)" "(R)" "(A)")
                     ("(R)" "(A)" "(R)" "(R)" "(A)" "(R)" "(A)")
                     ("(R)" "(A)" "(A)" "(A)" "(R)" "(R)" "(A)"))
                    (1 "Mateo" ("rojo" . "(R)") 0 0 2 0)
                    (2 "Cristobal" ("amarillo" . "(A)") 0 0 2 0)))

(define tablero-2 '((("( )" "( )" "( )" "( )" "( )" "(M)" "(M)")
                     ("( )" "( )" "( )" "( )" "( )" "(A)" "(A)")
                     ("( )" "( )" "( )" "(A)" "( )" "(M)" "(A)")
                     ("(A)" "(A)" "( )" "(M)" "( )" "(M)" "(M)")
                     ("(M)" "(A)" "(M)" "(M)" "(M)" "(M)" "(A)")
                     ("(A)" "(A)" "(M)" "(A)" "(A)" "(A)" "(M)"))
                    (1 "Toto" ("azul" . "(A)") 0 2 0 8)
                    (2 "PapaFrita" ("morado" . "(M)") 2 0 0 8)))

(define tablero-3 '((("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                     ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                     ("( )" "( )" "(R)" "( )" "( )" "( )" "( )")
                     ("( )" "( )" "(R)" "( )" "(A)" "(A)" "(A)")
                     ("( )" "( )" "(R)" "(A)" "(R)" "(R)" "(R)")
                     ("(A)" "(A)" "(R)" "(R)" "(A)" "(A)" "(R)"))
                    (1 "Mateo" ("rojo" . "(R)") 2 0 1 12)
                    (2 "Cristobal" ("amarillo" . "(A)") 0 2 1 13)))

(define tablero-4 '((("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                     ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                     ("( )" "( )" "( )" "(R)" "( )" "( )" "( )")
                     ("( )" "( )" "(R)" "(R)" "( )" "( )" "( )")
                     ("(Y)" "(R)" "(R)" "(Y)" "( )" "( )" "( )")
                     ("(R)" "(Y)" "(Y)" "(Y)" "( )" "( )" "( )"))
                    (1 "Juan" ("red" . "(R)") 2 0 0 4)
                    (2 "Mauricio" ("yellow" . "(Y)") 0 2 0 5)))


;RF5: board-can-play?
(display "\nRF5: board-can-play?\n")
(board-can-play? tablero-1)
(board-can-play? tablero-2)
(board-can-play? tablero-vacio)



;RF6: board-set-play-piece
(define b1 (board-set-play-piece b0 6 red-piece))
(define b2 (board-set-play-piece b1 6 yellow-piece))
(define b3 (board-set-play-piece b2 0 purple-piece))
(display "\nRF6: board-set-play-piece\n")
b1
b2
b3



;RF7: board-check-vertical-win
(display "\nRF7: board-check-vertical-win\n")
(board-check-vertical-win tablero-1)
(board-check-vertical-win tablero-2)
(board-check-vertical-win tablero-3)



;RF8: board-check-horizontal-win
(display "\nRF8: board-check-horizontal-win\n")
(board-check-horizontal-win tablero-1)
(board-check-horizontal-win tablero-2)
(board-check-horizontal-win tablero-3)



;RF9: board-check-diagonal-win
(display "\nRF9: board-check-diagonal-win\n")
(board-check-diagonal-win tablero-1)
(board-check-diagonal-win tablero-3)
(board-check-diagonal-win tablero-4)



;RF10: board-who-is-winner
(display "\nRF10: board-who-is-winner\n")
(board-who-is-winner tablero-1)
(board-who-is-winner tablero-2)
(board-who-is-winner tablero-3)



;RF11: game
(define new-game (game p1 p2 empty-board 1))
(define updated-game (game p1 p3 tablero-1 2))
;juego de ejemplo
(define game-1 '((1 "Juan" ("red" . "(R)") 0 0 0 5)
                 (2 "Mauricio" ("yellow" . "(Y)") 0 0 0 5)
                 ((("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                   ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                   ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                   ("( )" "( )" "(R)" "(R)" "( )" "( )" "( )")
                   ("(Y)" "(R)" "(R)" "(Y)" "( )" "( )" "( )")
                   ("(R)" "(Y)" "(Y)" "(Y)" "( )" "( )" "( )"))
                  (1 "Juan" ("red" . "(R)") 0 0 0 5)
                  (2 "Mauricio" ("yellow" . "(Y)") 0 0 0 5))
                 1
                 ((0 . "red")
                  (1 . "yellow")
                  (1 . "red")
                  (2 . "yellow")
                  (2 . "red")
                  (3 . "yellow")
                  (2 . "red")
                  (3 . "yellow")
                  (3 . "red")
                  (0 . "yellow"))))

(display "\nRF11: game\n")
new-game
(display "--------------------------\n")
updated-game
(display "--------------------------\n")
game-1



;RF12: game-history
(display "\nRF12: game-history\n")
(game-history new-game)
(game-history updated-game)
(game-history game-1)



;RF13: game-is-draw?
(display "\nRF13: game-is-draw?\n")
(game-is-draw? new-game)
(game-is-draw? updated-game)
(game-is-draw? game-1)



;RF14: player-update-stats
(define updated-player (player-update-stats p1 "win"))
(define updated-player-1 (player-update-stats p2 "loss"))
(define updated-player-2 (player-update-stats p3 "draw"))
(display "\nRF14: player-update-stats\n")
updated-player
updated-player-1
updated-player-2


;RF15: game-get-current-player
(display "\nRF15: game-get-current-player\n")
(game-get-current-player new-game)
(game-get-current-player updated-game)
(game-get-current-player game-1)


;RF16: game-get-board
(display "\nRF16: game-get-board\n")
(game-get-board new-game)
(display "--------------------------\n")
(game-get-board updated-game)
(display "--------------------------\n")
(game-get-board game-1)



;RF17: game-set-end
(define ended-game-1 (game-set-end new-game))
(define ended-game-2 (game-set-end updated-game))
(define ended-game-3 (game-set-end game-1))
(display "\nRF17: game-set-end\n")
ended-game-1
(display "--------------------------\n")
ended-game-2
(display "--------------------------\n")
ended-game-3



;RF18: game-player-set-move
(define ug1 (game-player-set-move new-game p1 3))
(define ug2 (game-player-set-move ug1 p2 4))
(define ug3 (game-player-set-move ug2 p1 4))
(display "\nRF18: game-player-set-move\n")
ug1
(display "--------------------------\n")
ug2
(display "--------------------------\n")
ug3
