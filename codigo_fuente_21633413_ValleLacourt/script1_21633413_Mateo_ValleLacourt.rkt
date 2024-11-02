#lang racket
(require "TDA-player_21633413_ValleLacourt.rkt")
(require "TDA-piece_21633413_ValleLacourt.rkt")
(require "TDA-board_21633413_ValleLacourt.rkt")
(require "TDA-game_21633413_ValleLacourt.rkt")

; Script 1

; 1. Creación de jugadores 
(define p1 (player 1 "Mateo" "rojo" 0 0 0 21))
(define p2 (player 2 "Cristobal" "amarillo" 0 0 0 21))

; 2. Creación de piezas
(define red-piece (piece "rojo"))
(define yellow-piece (piece "amarillo"))

; 3. Creación del tablero inicial
(define empty-board (board))

; 4. Creación de un nuevo juego
(define g0 (game p1 p2 empty-board 1))

; 5. Realizando movimientos para empate
(define g1 (game-player-set-move g0 p1 0))  ; Mateo coloca en columna 0
(define g2 (game-player-set-move g1 p2 1))  ; Cristobal coloca en columna 1
(define g3 (game-player-set-move g2 p1 0))  ; Mateo coloca en columna 0
(define g4 (game-player-set-move g3 p2 1))  ; Cristobal coloca en columna 1
(define g5 (game-player-set-move g4 p1 0))  ; Mateo coloca en columna 0
(define g6 (game-player-set-move g5 p2 0))  ; Cristobal coloca en columna 0
(define g7 (game-player-set-move g6 p1 1))  ; Mateo coloca en columna 1
(define g8 (game-player-set-move g7 p2 3))  ; Cristobal coloca en columna 3
(define g9 (game-player-set-move g8 p1 3))  ; Mateo coloca en columna 3
(define g10 (game-player-set-move g9 p2 0)) ; Cristobal coloca en columna 0
(define g11 (game-player-set-move g10 p1 3)) ; Mateo coloca en columna 3 
(define g12 (game-player-set-move g11 p1 0))  ; Mateo intenta colocar en columna 0 en el turno de Cristobal, pero no puede
(define g13 (game-player-set-move g12 p2 2))  ; Cristobal coloca en columna 2
(define g14 (game-player-set-move g13 p1 4))  ; Mateo coloca en columna 4
(define g15 (game-player-set-move g14 p2 4))  ; Cristobal coloca en columna 4
(define g16 (game-player-set-move g15 p1 0))  ; Mateo coloca en columna 0
(define g17 (game-player-set-move g16 p2 0))  ; Cristobal intenta colocar en columna 0, pero no se puede
(define g18 (game-player-set-move g17 p2 3))  ; Cristobal coloca en columna 3
(define g19 (game-player-set-move g18 p1 5))  ; Mateo coloca en columna 5
(define g20 (game-player-set-move g19 p2 6))  ; Cristobal coloca en columna 6
(define g21 (game-player-set-move g20 p1 5))  ; Mateo coloca en columna 5
(define g22 (game-player-set-move g21 p2 6)) ; Cristobal coloca en columna 6
(define g23 (game-player-set-move g22 p1 5)) ; Mateo coloca en columna 5
(define g24 (game-player-set-move g23 p2 5)) ; Cristobal coloca en columna 5
(define g25 (game-player-set-move g24 p1 4)) ; Mateo coloca en columna 4
(define g26 (game-player-set-move g25 p2 6)) ; Cristobal coloca en columna 6
(define g27 (game-player-set-move g26 p1 6)) ; Mateo coloca en columna 6
(define g28 (game-player-set-move g27 p2 4)) ; Cristobal coloca en columna 4
(define g29 (game-player-set-move g28 p1 2)) ; Mateo coloca en columna 2
(define g30 (game-player-set-move g29 p2 2)) ; Cristobal coloca en columna 2
(define g31 (game-player-set-move g30 p1 6)) ; Mateo coloca en columna 6
(define g32 (game-player-set-move g31 p2 3)) ; Cristobal coloca en columna 3
(define g33 (game-player-set-move g32 p1 4)) ; Mateo coloca en columna 4
(define g34 (game-player-set-move g33 p2 6)) ; Cristobal coloca en columna 6
(define g35 (game-player-set-move g34 p1 1)) ; Mateo coloca en columna 1
(define g36 (game-player-set-move g35 p2 1)) ; Cristobal coloca en columna 1
(define g37 (game-player-set-move g36 p1 2)) ; Mateo coloca en columna 2
(define g38 (game-player-set-move g37 p2 5)) ; Cristobal coloca en columna 5
(define g39 (game-player-set-move g38 p1 2)) ; Mateo coloca en columna 2
(define g40 (game-player-set-move g39 p2 5)) ; Cristobal coloca en columna 5
(define g41 (game-player-set-move g40 p1 1)) ; Mateo coloca en columna 1
(define g42 (game-player-set-move g41 p2 3)) ; Cristobal coloca en columna 3
(define g43 (game-player-set-move g42 p1 4)) ; Mateo coloca en columna 4
(define g44 (game-player-set-move g43 p2 2)) ; Cristobal coloca en columna 2 (empate, sin espacio en tablero y sin fichas)


; 6. Verificaciones durante el juego
(display "¿Se puede jugar en el tablero vacío? ")
(board-can-play? empty-board)

(display "¿Se puede jugar después de 44 movimientos? ")
(board-can-play? (game-get-board g44))

(display "Jugador actual después de 12 movimientos: ")
(game-get-current-player g12)

; 7. Verificación de victoria
(display "Verificación de victoria vertical: ")
(board-check-vertical-win (game-get-board g44))

(display "Verificación de victoria horizontal: ")
(board-check-horizontal-win (game-get-board g44))

(display "Verificación de victoria diagonal: ")
(board-check-diagonal-win (game-get-board g44))

(display "Verificación de ganador: ")
(board-who-is-winner (game-get-board g44))

; 8. Verificación de empate
(display "¿Es empate? ")
(game-is-draw? g44)

; 9. Finalizar el juego y actualizar estadísticas
(define ended-game (game-set-end g44)) ;como la funcion game-player-set-move ya actualiza las stats, se le agregan mas stats a este estado de juego

; 10. Actualizar estadísticas de los jugadores
(define updated-p1 (player-update-stats p1 "draw"))
(display "jugador-1 despues del juego-1")
updated-p1

(define updated-p2 (player-update-stats p2 "draw"))
(display "jugador-2 despues del juego-1")
updated-p2

; 11. Mostrar historial de movimientos
(display "Historial de movimientos:\n")
(game-history ended-game)

; 12. Mostrar estado final del tablero
(display "Estado final del tablero:\n")
(game-get-board ended-game)

; 13. Iniciar segundo juego
(define g2.0 (game updated-p1 updated-p2 empty-board 1))

; 14. Realizando movimientos para victoria vertical
(define g2.1 (game-player-set-move g2.0 p1 6))  ; Mateo coloca en columna 6
(define g2.2 (game-player-set-move g2.1 p2 4))  ; Cristobal coloca en columna 4
(define g2.3 (game-player-set-move g2.2 p1 6))  ; Mateo coloca en columna 6
(define g2.4 (game-player-set-move g2.3 p2 6))  ; Cristobal coloca en columna 6
(define g2.5 (game-player-set-move g2.4 p1 3))  ; Mateo coloca en columna 3
(define g2.6 (game-player-set-move g2.5 p2 5))  ; Cristobal coloca en columna 5
(define g2.7 (game-player-set-move g2.6 p1 5))  ; Mateo coloca en columna 5
(define g2.8 (game-player-set-move g2.7 p2 1))  ; Cristobal coloca en columna 1
(define g2.9 (game-player-set-move g2.8 p1 4))  ; Mateo coloca en columna 4
(define g2.10 (game-player-set-move g2.9 p2 3)) ; Cristobal coloca en columna 3
(define g2.11 (game-player-set-move g2.10 p1 2)) ; Mateo coloca en columna 2
(define g2.12 (game-player-set-move g2.11 p2 0))  ; Cristobal coloca en columna 0
(define g2.13 (game-player-set-move g2.12 p1 2))  ; Mateo coloca en columna 2
(define g2.14 (game-player-set-move g2.13 p2 5))  ; Cristobal coloca en columna 5
(define g2.15 (game-player-set-move g2.14 p1 2))  ; Mateo coloca en columna 2
(define g2.16 (game-player-set-move g2.15 p2 4))  ; Cristobal coloca en columna 4
(define g2.17 (game-player-set-move g2.16 p1 2))  ; Mateo coloca en columna 2 (victoria vertical)

; 15. Verificaciones durante el juego
(display "\n\n¿Se puede jugar en el tablero vacío? ")
(board-can-play? empty-board)

(display "¿Se puede jugar después de 17 movimientos? ")
(board-can-play? (game-get-board g2.17))

(display "Jugador actual después de 17 movimientos: ")
(game-get-current-player g2.17)

; 16. Verificación de victoria
(display "Verificación de victoria vertical: ")
(board-check-vertical-win (game-get-board g2.17))

(display "Verificación de victoria horizontal: ")
(board-check-horizontal-win (game-get-board g2.17))

(display "Verificación de victoria diagonal: ")
(board-check-diagonal-win (game-get-board g2.17))

(display "Verificación de ganador: ")
(board-who-is-winner (game-get-board g2.17))

; 17. Verificación de empate
(display "¿Es empate? ")
(game-is-draw? g2.17)

; 18. Finalizar el juego y actualizar estadísticas
(define ended-game-2 (game-set-end g2.17)) ;como la funcion game-player-set-move ya actualiza las stats, se le agregan mas stats a este estado de juego

; 19. Actualizar estadísticas de los jugadores
(define updated-2-p1 (player-update-stats updated-p1 "win"))
(display "jugador-1 despues del juego-2")
updated-2-p1

(define updated-2-p2 (player-update-stats updated-p2 "loss"))
(display "jugador-2 despues del juego-2")
updated-2-p2

; 20. Mostrar historial de movimientos
(display "Historial de movimientos:\n")
(game-history ended-game-2)

; 21. Mostrar estado final del tablero
(display "Estado final del tablero:\n")
(game-get-board ended-game-2)




;-------------------------------------------------------------------------------|
;                                                                               |
;        3 ejemplos de uso de cada funcion de los requisitos funcionales:       |
;                                                                               |
;-------------------------------------------------------------------------------|
(display "\n\n\n\n-------------------------------\n3 Ejemplos de uso por cada RF\n-------------------------------\n")

;RF2: player
(define p-1 (player 1 "Toto" "purple" 0 0 0 21))
(define p-2 (player 2 "Cristobal" "amarillo" 0 0 0 21))
(define p-3 (player 3 "Mateo" "rojo" 0 0 0 21))
(define p-4 (player 4 "PapaFrita" "morado" 0 0 0 21))
(display "\nRF2: player\n")
p-1
p-2
p-3


;RF3: piece
(define Red-piece (piece "red"))
(define Yellow-piece (piece "yellow"))
(define Purple-piece (piece "purple"))
(display "\nRF3: piece\n")
Red-piece
Yellow-piece
Purple-piece



;RF4: board
(define Empty-board (board))
(define b0 (board))
(define tablero-vacio (board))
(display "\nRF4: board\n")
Empty-board
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
                    (1 "Toto" ("azul" . "(A)") 0 1 0 8)
                    (2 "PapaFrita" ("morado" . "(M)") 1 0 0 8)))

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
(board-can-play? tablero-2) ;falso porq ya hay una victoria
(board-can-play? tablero-vacio)



;RF6: board-set-play-piece
(define b1 (board-set-play-piece b0 6 Red-piece))
(define b2 (board-set-play-piece b1 6 Yellow-piece))
(define b3 (board-set-play-piece b2 0 Purple-piece))
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
(define new-game (game p-1 p-2 empty-board 1))
(define updated-game (game p-3 p-2 tablero-1 2))
(define nuevo-juego (game p-1 p-4 tablero-2 1))
(display "\nRF11: game\n")
new-game
(display "--------------------------\n")
updated-game
(display "--------------------------\n")
nuevo-juego


;juegos de ejemplo
(define game-1 '((1 "Juan" ("red" . "(R)") 0 0 0 5)
                 (2 "Mauricio" ("yellow" . "(Y)") 0 0 0 5)
                 ((("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                   ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                   ("( )" "( )" "( )" "(R)" "( )" "( )" "( )")
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

(define game-2 '((1 "Toto" ("azul" . "(A)") 0 0 0 8)
                 (2 "PapaFrita" ("morado" . "(M)") 0 0 0 8)
                 ((("( )" "( )" "( )" "( )" "( )" "(M)" "(M)")
                   ("( )" "( )" "( )" "( )" "( )" "(A)" "(A)")
                   ("( )" "( )" "( )" "(A)" "( )" "(M)" "(A)")
                   ("(A)" "(A)" "( )" "(M)" "( )" "(M)" "(M)")
                   ("(M)" "(A)" "(M)" "(M)" "(M)" "(M)" "(A)")
                   ("(A)" "(A)" "(M)" "(A)" "(A)" "(A)" "(M)"))
                  (1 "Toto" ("azul" . "(A)") 0 0 0 8)
                  (2 "PapaFrita" ("morado" . "(M)") 0 0 0 8))
                 1
                 ((0 . "azul")
                  (2 . "morado")
                  (3 . "azul")
                  (0 . "morado")
                  (4 . "azul")
                  (2 . "morado")
                  (5 . "azul")
                  (6 . "morado")
                  (6 . "azul")
                  (5 . "morado")
                  (1 . "azul")
                  (5 . "morado")
                  (1 . "azul")
                  (5 . "morado")
                  (5 . "azul")
                  (6 . "morado")
                  (6 . "azul")
                  (5 . "morado")
                  (6 . "azul")
                  (3 . "morado")
                  (0 . "azul")
                  (3 . "morado")
                  (1 . "azul")
                  (6 . "morado")
                  (3 . "azul")
                  (4 . "morado"))))



;RF12: game-history
(display "\nRF12: game-history\n")
(game-history new-game)
(display "--------------------------\n")
(game-history game-1)
(display "--------------------------\n")
(game-history game-2)



;RF13: game-is-draw?
(display "\nRF13: game-is-draw?\n")
(game-is-draw? new-game)
(game-is-draw? updated-game) ;juego hecho con tablero lleno
(game-is-draw? game-1)       ;juego con victoria



;RF14: player-update-stats
(define updated-player (player-update-stats p-1 "win"))
(define updated-player-1 (player-update-stats p-2 "loss"))
(define updated-player-2 (player-update-stats p-3 "draw"))
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
(define Ended-game-1 (game-set-end game-2)) ;victoria horizontal de jugador 2, ficha (M)
(define Ended-game-2 (game-set-end updated-game)) ; empate, tablero lleno
(define Ended-game-3 (game-set-end game-1)) ; victoria diagonal de jugador 1, ficha (R)
(display "\nRF17: game-set-end\n")
Ended-game-1
(display "--------------------------\n")
Ended-game-2
(display "--------------------------\n")
Ended-game-3



;RF18: game-player-set-move
(define ug1 (game-player-set-move new-game p-1 3))
(define ug2 (game-player-set-move ug1 p-2 4))
(define ug3 (game-player-set-move ug2 p-1 4))
(display "\nRF18: game-player-set-move\n")
ug1
(display "--------------------------\n")
ug2
(display "--------------------------\n")
ug3