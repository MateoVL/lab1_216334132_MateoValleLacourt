#lang racket
(require "TDA-player.rkt")
(require "TDA-piece.rkt")


(provide board)
(provide board-can-play?)
(provide board-set-play-piece)
(provide board-check-vertical-win)
(provide board-check-horizontal-win)
(provide board-check-diagonal-win)


;;;TDA board: Estructura que representa un tablero 6x7 de conecta 4 en base de una matriz, hecha con una lista de listas.



 ;;;;;;;;;;;;;;;;;
 ; CONSTRUCTORES ;
 ;;;;;;;;;;;;;;;;;


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




 ;;;;;;;;;;;;;;;
 ; PERTENENCIA ;
 ;;;;;;;;;;;;;;;



 ;;;;;;;;;;;;;;
 ; SELECTORES ;
 ;;;;;;;;;;;;;;


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



; Descripción: funcion que retorna el elemento del tablero dada una fila y una columna.
; Dom: tablero (board) X fila (int) X columna (int)
; Rec: posicion vertical donde caería la ficha (int)
; Tipo recursión: No aplica

(define board-get-elem
  (lambda (board fila columna)
    (list-ref (list-ref board fila) columna)))



; Descripción: funcion que retorna la posicion vertical en la que caería la ficha en una columna dada.
; Dom: tablero (board) X columna (int)
; Rec: posicion vertical donde caería la ficha (int)
; Tipo recursión: Natural

(define board-get-fila-baja
  (lambda (tablero columna)

    (define fila-baja-in
      (lambda (tablero fila columna)
        (cond
          [(< fila 0) -1]
          [(not(piece? (board-get-elem tablero fila columna))) fila]
          [(fila-baja-in tablero (sub1 fila) columna)])))
    
    (fila-baja-in tablero board-get-filas columna)))




 ;;;;;;;;;;;;;;;;;
 ; MODIFICADORES ;
 ;;;;;;;;;;;;;;;;;


; Descripción: funcion que modifica un elemento del tablero dada una fila y una columna.
; Dom: board (board) X fila (int) X columna (int) X elem (piece)
; Rec: tablero modificado (board)
; Tipo recursión: No aplica

(define board-set-elem
  (lambda (board fila columna elem)
    (if (equal? fila -1) -1 (list-set board fila (list-set (list-ref board fila) columna elem)))))



; Descripción: funcion que permite realizar una jugada en el tablero declarativamente.
; Dom: board (board) X column (int) X piece (piece)
; Rec: tablero actualizado (board)
; Tipo recursión: No aplica

(define board-set-play-piece
  (lambda (board column piece)
    (board-set-elem board (board-get-fila-baja board column) column piece)))




 ;;;;;;;;;
 ; OTROS ;
 ;;;;;;;;;


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

(define board-check-vertical-win
  (lambda (board)

    (define vertical-win
          (lambda (board fila columna contador)
            (cond
              [(> columna board-get-columnas) 0]

              [(and (equal? contador 4) (equal? (board-get-elem board fila columna) red-piece)) 1]

              [(and (equal? contador 4) (equal? (board-get-elem board fila columna) yellow-piece)) 2]

              [(equal? fila board-get-filas) (vertical-win board 0 (add1 columna) 1)]

              [(equal? (board-get-elem board fila columna) (board-get-elem board (add1 fila) columna)) (vertical-win board (add1 fila) columna (add1 contador))]

              [else (vertical-win board (add1 fila) columna 1)])))

    (vertical-win board 0 0 1)))



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

    (define recorrer-filas
      (lambda (board pos-fila)

        ; Descripción: funcion que dada una lista, revisa recursivamente si hay 4 elementos iguales consecutivos, si lo hay, retorna dicho elemento, si no, falso.
        ; Dom: lista (list) X pos (int) X contador (int)
        ; Rec: ficha-repetida (piece) | falso (boolean)
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
          [else (recorrer-filas board (add1 pos-fila))])))
    
    (recorrer-filas board 0)))



; Descripción: funcion que permite verificar si algun jugador ha ganado diagonalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador diagonal.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Cola/Backtracking

(define board-check-diagonal-win
  (lambda (board)

    ; Descripción: Para generalizar, las siguientes 4 funciones check dentro de board-check-diagonal-win hacen lo mismo pero en distintas direcciones, utilizan recursion natural para ver si hay 4 fichas iguales en una direccion diagonal y retorna 1,2 o 0 dependiendo de la funcion de afuera.
    ; Dom: board (board) X fila (int) X columna (int) X contador (int)
    ; Rec: 1 (int) | 2 (int) | 0 (int)
    ; Tipo recursión: Natural
    (define check-up-der
      (lambda (board fila columna contador)
        (cond
          [(or (< fila 0) (< columna 0) (> fila board-get-filas) (> columna board-get-columnas)) #f]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) red-piece)) 1]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) yellow-piece)) 2]
          [(or (< (sub1 fila) 0) (> (add1 columna) board-get-columnas)) #f]
          [(equal? (board-get-elem board fila columna) (board-get-elem board (sub1 fila) (add1 columna))) (check-up-der board (sub1 fila) (add1 columna) (add1 contador))]
          [else #f])))

    (define check-up-izq
      (lambda (board fila columna contador)
        (cond
          [(or (< fila 0) (< columna 0) (> fila board-get-filas) (> columna board-get-columnas)) #f]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) red-piece)) 1]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) yellow-piece)) 2]
          [(or (< (sub1 fila) 0) (< (sub1 columna) 0)) #f]
          [(equal? (board-get-elem board fila columna) (board-get-elem board (sub1 fila) (sub1 columna))) (check-up-izq board (sub1 fila) (sub1 columna) (add1 contador))]
          [else #f])))

    (define check-down-der
      (lambda (board fila columna contador)
        (cond
          [(or (< fila 0) (< columna 0) (> fila board-get-filas) (> columna board-get-columnas)) #f]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) red-piece)) 1]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) yellow-piece)) 2]
          [(or (> (add1 fila) board-get-filas) (> (add1 columna) board-get-columnas)) #f]
          [(equal? (board-get-elem board fila columna) (board-get-elem board (add1 fila) (add1 columna))) (check-down-der board (add1 fila) (add1 columna) (add1 contador))]
          [else #f])))

    (define check-down-izq
      (lambda (board fila columna contador)
        (cond
          [(or (< fila 0) (< columna 0) (> fila board-get-filas) (> columna board-get-columnas)) #f]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) red-piece)) 1]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) yellow-piece)) 2]
          [(or (> (add1 fila) board-get-filas) (< (sub1 columna) 0)) #f]
          [(equal? (board-get-elem board fila columna) (board-get-elem board (add1 fila) (sub1 columna))) (check-down-izq board (add1 fila) (sub1 columna) (add1 contador))]
          [else #f])))

    ; Descripción: funcion que utiliza las 4 anteriores en cada posicion del tablero para verificar si existe alguna win en diagonal o no.
    ; Dom: board (board) X fila (int) X columna (int)
    ; Rec: 1 (int) | 2 (int) | 0 (int)
    ; Tipo recursión: Natural
    (define check-all-diagonal
      (lambda (board fila columna)
      (cond
        [(and (equal? fila board-get-filas) (equal? columna board-get-columnas)) 0]
        [(> columna board-get-columnas) (check-all-diagonal board (add1 fila) 0)]
        [(not (equal? (check-up-der board fila columna 1) #f)) (check-up-der board fila columna 1)]
        [(not (equal? (check-up-izq board fila columna 1) #f)) (check-up-izq board fila columna 1)]
        [(not (equal? (check-down-der board fila columna 1) #f)) (check-down-der board fila columna 1)]
        [(not (equal? (check-down-izq board fila columna 1) #f)) (check-down-izq board fila columna 1)]
        [else (check-all-diagonal board fila (add1 columna))])))


    (check-all-diagonal board 0 0)))



; Descripción: funcion que verifica el estado del tablero y entregar el posible ganador.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: No aplica
; IDEA: Realizar de forma declarativa.
;(define board-who-is-winner
;  (lambda board int #|trabajar|#))

;ejemplo de uso: (board-who-is-winner updated-board)