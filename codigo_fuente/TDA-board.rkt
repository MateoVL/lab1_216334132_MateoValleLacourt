#lang racket
(require "TDA-player.rkt")
(require "TDA-piece.rkt")
;(require "TDA-game.rkt")


(provide board)
(provide board-can-play?)
(provide board-get-filas)
(provide board-get-columnas)
(provide board-get-fila-baja)
(provide board-set-play-piece)

(provide board-check-horizontal-win)


;;;TDA board: Estructura que representa un tablero 6x7 de conecta 4 en base de una matriz, hecha con una lista de listas.


;;CONSTRUCTORES


; Descripción: funcion que crea un tablero de conecta 4.
; Dom: sin parametros de entrada
; Rec: tablero vacio (board)
; Tipo recursión: No aplica
; TAREA: definir que es vacio

(define (board) '((0 0 0 0 0 0 0)
                 (0 0 0 0 0 0 0)
                 (0 0 0 0 0 0 0)
                 (0 0 0 0 0 0 0)
                 (0 0 0 0 0 0 0)
                 (0 0 0 0 0 0 0)))



;;PERTENENCIA


;;SELECTORES


; Descripción: funcion que retorna la cantidad de filas del tablero conecta 4.
; Dom: sin parametros de entrada
; Rec: cantidad-filas (int)
; Tipo recursión: No aplica

(define board-get-filas 5)



; Descripción: funcion que retorna la cantidad de columnas del tablero conecta 4.
; Dom: sin parametros de entrada
; Rec: cantidad columnas (int)
; Tipo recursión: No aplica

(define board-get-columnas 6)



; Descripción: funcion que retorna la posicion vertical en la que caería la ficha en una columna dada.
; Dom: tablero (board) X fila (int) X columna (int)
; Rec: posicion vertical donde caería la ficha (int)
; Tipo recursión: Natural

(define board-get-fila-baja
  (lambda (tablero columna)
    (define fila 5)
    (define fila-baja-in
      (lambda (tablero fila columna)
      (cond
        [(< fila 0) -1]
        [(not(piece? (list-ref (list-ref tablero fila) columna))) fila]
        [(fila-baja-in tablero (sub1 fila) columna)])))
    (fila-baja-in tablero fila columna)))


      
;;MODIFICADORES


; Descripción: funcion que permite realizar una jugada en el tablero.
; Dom: board (board) X column (int) X piece (piece)
; Rec: tablero actualizado (board)
; Tipo recursión: No aplica

(define board-set-play-piece
  (lambda (board column piece)
    (list-set board
              (board-get-fila-baja board column)
              (list-set (list-ref board (board-get-fila-baja board column)) column piece)) ))



;;OTROS


; Descripción: funcion que permite verificar si se pueden hacer mas jugadas en el tablero, true: si se puede, false: no se puede.
; Dom: board (board)
; Rec: se puede jugar? (boolean)
; Tipo recursión: No aplica

(define board-can-play?
  (lambda (board) (list? (member 0 (first board)))))



; Descripción: funcion que permite verificar si algun jugador ha ganado verticalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Natural

;(define board-check-vertical-win
;  (lambda board int #|trabajar|#))



; Descripción: funcion que permite verificar si algun jugador ha ganado horizontalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador horizontal.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Natural

(define board-check-horizontal-win
  (lambda (board)
   
    ; Descripción: funcion que aplica a cada fila la funcion horizontal-win-fila, verifica recursivamente, si la funcion es pieza roja, retorna 1(asumiendo que jugador 1 elije siempre rojo y jugador 2 amarillo), 2 si es amarillo y 0 si no hay victorias.
    ; Dom: board (board) X pos-fila (int)
    ; Rec: 1 (int) | 2 (int) | 0 (int)
    ; Tipo recursión: Natural

    (define recorrer-board
      (lambda (board pos-fila)

        ; Descripción: funcion que dada una lista, revisa recursivamente si hay 4 elementos iguales consecutivos, si lo hay, retorna dicho elemento, si no, falso.
        ; Dom: lista (list) X pos (int) X contador (int)
        ; Rec: dato-repetido (any) | falso (boolean)
        ; Tipo recursión: Natural
    
        (define horizontal-win-fila
          (lambda (lista pos contador)
            (cond
              [(equal? contador 4) (list-ref lista pos)]
              [(and (equal? pos board-get-columnas) (not(equal? contador 4))) #f]
              [(equal? (list-ref lista pos) (list-ref lista (add1 pos))) (horizontal-win-fila lista (add1 pos) (add1 contador))]
              [else (horizontal-win-fila lista (add1 pos) 1)])))

        (cond
          [(> pos-fila board-get-filas) 0]
          [(equal? (horizontal-win-fila (list-ref board pos-fila) 0 1) red-piece) 1]
          [(equal? (horizontal-win-fila (list-ref board pos-fila) 0 1) yellow-piece) 2]
          [else (recorrer-board board (add1 pos-fila))])))
    
    (if (equal? (recorrer-board board 0) 1) 1 (if (equal? (recorrer-board board 0) 2) 2 0))))



; Descripción: funcion que permite verificar si algun jugador ha ganado diagonalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador diagonal.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Natural o cola
;(define board-check-diagonal-win
;  (lambda board int #|trabajar|#))

;ejemplo de uso: (board-check-diagonal-win updated-board)



; Descripción: funcion que verifica el estado del tablero y entregar el posible ganador.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: No aplica
; IDEA: Realizar de forma declarativa.
;(define board-who-is-winner
;  (lambda board int #|trabajar|#))

;ejemplo de uso: (board-who-is-winner updated-board)


