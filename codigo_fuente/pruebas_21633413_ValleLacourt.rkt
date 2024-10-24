#lang racket
(require "TDA-player.rkt")
(require "TDA-piece.rkt")
(require "TDA-board.rkt")
(require "TDA-game.rkt")


;ejemplos de uso:

;RF2: player
(define p1 (player 1 "Juan" "red" 0 0 0 21))
(define p2 (player 2 "Juan" "yellow" 0 0 0 21))
(define p3 (player 1 "Mateo" "purple" 10 5 2 21))
(display "\nRF2: player")
p1
p2
p3


;RF3: piece
(define red-piece (piece "red"))
(define yellow-piece (piece "yellow"))
(define purple-piece (piece "purple"))
(display "\nRF3: piece")
red-piece
yellow-piece
purple-piece



;RF4: board
(define empty-board (board))
(define b0 (board))
(define tablero-vacio (board))
(display "\nRF4: board")
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
(display "\nRF5: board-can-play?")
(board-can-play? tablero-1)
(board-can-play? tablero-2)
(board-can-play? tablero-vacio)



;RF6: board-set-play-piece
(define b1 (board-set-play-piece b0 6 red-piece))
(define b2 (board-set-play-piece b1 6 yellow-piece))
(define b3 (board-set-play-piece b2 0 purple-piece))
(display "\nRF6: board-set-play-piece")
b1
b2
b3



;RF7: board-check-vertical-win
(display "\nRF7: board-check-vertical-win")
(board-check-vertical-win tablero-1)
(board-check-vertical-win tablero-2)
(board-check-vertical-win tablero-3)



;RF8: board-check-horizontal-win
(display "\nRF8: board-check-horizontal-win")
(board-check-horizontal-win tablero-1)
(board-check-horizontal-win tablero-2)
(board-check-horizontal-win tablero-3)



;RF9: board-check-diagonal-win
(display "\nRF9: board-check-diagonal-win")
(board-check-diagonal-win tablero-1)
(board-check-diagonal-win tablero-3)
(board-check-diagonal-win tablero-4)



;RF10: board-who-is-winner
(display "\nRF10: board-who-is-winner")
(board-who-is-winner tablero-1)
(board-who-is-winner tablero-2)
(board-who-is-winner tablero-3)



;RF11: game
(define new-game (game p1 p2 empty-board 1))
(define updated-game (game p1 p3 tablero-1 2))
(define ug2 (game p1 p2 tablero-2 1))
(display "\nRF11: game")
new-game
updated-game
ug2



;game-history
;(game-history new-game)



;game-is-draw?
;(game-is-draw? ug3)



;updated-player
;(define updated-player (player-update-stats p1 "win"))



;game-get-current-player
;(game-get-current-player new-game)


;(define ended-game (game-set-end ug2))
;(define ug1 (game-player-set-move new-game p1 3))
;(define ug2 (game-player-set-move ug1 p2 4))
;(define ug3 (game-player-set-move ug2 p1 4))

;(game-set-history ug1 (cons 5 6))


#|
(define lista
  (list 1 2 3 4))

(define set-final
  (lambda (lista elem)
    (reverse (cons elem (reverse lista)))))



(define caracter
  (lambda (cadena)
    (string-upcase (string #\( (string-ref cadena 0) #\)))))|#

