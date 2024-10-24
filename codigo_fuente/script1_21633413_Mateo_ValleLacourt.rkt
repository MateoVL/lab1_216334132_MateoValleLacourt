#lang racket
(require "TDA-player.rkt")
(require "TDA-piece.rkt")
(require "TDA-board.rkt")
(require "TDA-game.rkt")

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