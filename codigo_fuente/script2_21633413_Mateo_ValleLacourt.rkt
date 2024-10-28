#lang racket
(require "TDA-player.rkt")
(require "TDA-piece.rkt")
(require "TDA-board.rkt")
(require "TDA-game.rkt")

; Script 2

; 1. Creación de jugadores 
(define jugador1 (player 1 "Toto" "azul" 0 0 0 21))
(define jugador2 (player 2 "PapaFrita" "morado" 0 0 0 21))

; 2. Creación de piezas
(define blue-piece (piece "azul"))
(define purple-piece (piece "morado"))

; 3. Creación del tablero inicial
(define empty-board (board))

; 4. Creación de un nuevo juego
(define g0 (game jugador1 jugador2 empty-board 1))

; 5. Realizando movimientos para victoria horizontal
(define g1 (game-player-set-move g0 jugador1 0))  ; Toto coloca en columna 0
(define g2 (game-player-set-move g1 jugador2 2))  ; PapaFrita coloca en columna 2
(define g3 (game-player-set-move g2 jugador1 3))  ; Toto coloca en columna 3
(define g4 (game-player-set-move g3 jugador2 0))  ; PapaFrita coloca en columna 0
(define g5 (game-player-set-move g4 jugador1 4))  ; Toto coloca en columna 4
(define g6 (game-player-set-move g5 jugador2 2))  ; PapaFrita coloca en columna 2
(define g7 (game-player-set-move g6 jugador1 5))  ; Toto coloca en columna 5
(define g8 (game-player-set-move g7 jugador2 6))  ; PapaFrita coloca en columna 6
(define g9 (game-player-set-move g8 jugador1 6))  ; Toto coloca en columna 6
(define g10 (game-player-set-move g9 jugador2 5)) ; PapaFrita coloca en columna 5
(define g11 (game-player-set-move g10 jugador1 1)) ; Toto coloca en columna 1
(define g12 (game-player-set-move g11 jugador2 5))  ; PapaFrita coloca en columna 5
(define g13 (game-player-set-move g12 jugador1 1))  ; Toto coloca en columna 1
(define g14 (game-player-set-move g13 jugador2 5))  ; PapaFrita coloca en columna 5
(define g15 (game-player-set-move g14 jugador1 5))  ; Toto coloca en columna 5
(define g16 (game-player-set-move g15 jugador2 6))  ; PapaFrita coloca en columna 6
(define g17 (game-player-set-move g16 jugador1 6))  ; Toto coloca en columna 6
(define g18 (game-player-set-move g17 jugador2 5))  ; PapaFrita coloca en columna 5
(define g19 (game-player-set-move g18 jugador1 6))  ; Toto coloca en columna 6
(define g20 (game-player-set-move g19 jugador2 3))  ; PapaFrita coloca en columna 3
(define g21 (game-player-set-move g20 jugador1 0))  ; Toto coloca en columna 0
(define g22 (game-player-set-move g21 jugador2 3))  ; PapaFrita coloca en columna 3
(define g23 (game-player-set-move g22 jugador1 1))  ; Toto coloca en columna 1
(define g24 (game-player-set-move g23 jugador2 6))  ; PapaFrita coloca en columna 6
(define g25 (game-player-set-move g24 jugador1 3))  ; Toto coloca en columna 3
(define g26 (game-player-set-move g25 jugador2 4))  ; PapaFrita coloca en columna 4


; 6. Verificaciones durante el juego
(display "¿Se puede jugar en el tablero vacío? ")
(board-can-play? empty-board)

(display "¿Se puede jugar después de 26 movimientos? ")
(board-can-play? (game-get-board g26))

(display "Jugador actual después de 26 movimientos: ")
(game-get-current-player g26)

; 7. Verificación de victoria
(display "Verificación de victoria vertical: ")
(board-check-vertical-win (game-get-board g26))

(display "Verificación de victoria horizontal: ")
(board-check-horizontal-win (game-get-board g26))

(display "Verificación de victoria diagonal: ")
(board-check-diagonal-win (game-get-board g26))

(display "Verificación de ganador: ")
(board-who-is-winner (game-get-board g26))

; 8. Verificación de empate
(display "¿Es empate? ")
(game-is-draw? g26)

; 9. Finalizar el juego y actualizar estadísticas
(define ended-game (game-set-end g26)) ;como la funcion game-player-set-move ya actualiza las stats, se le agregan mas stats a este estado de juego

; 10. Actualizar estadísticas de los jugadores
(define updated-jugador1 (player-update-stats jugador1 "loss"))
(display "jugador-1 despues del juego")
updated-jugador1

(define updated-jugador2 (player-update-stats jugador2 "win"))
(display "jugador-2 despues del juego")
updated-jugador2

; 11. Mostrar historial de movimientos
(display "Historial de movimientos:\n")
(game-history ended-game)

; 12. Mostrar estado final del tablero
(display "Estado final del tablero:\n")
(game-get-board ended-game)
