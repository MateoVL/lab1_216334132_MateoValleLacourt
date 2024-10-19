#lang racket
(require "TDA-player.rkt")
(require "TDA-piece.rkt")

(provide board)
(provide board-can-play?)
(provide board-set-play-piece)
(provide board-check-vertical-win)
(provide board-check-horizontal-win)
(provide board-check-diagonal-win)
(provide board-who-is-winner)


;;;TDA board: Estructura que representa un tablero 6x7 de conecta 4 en base de una matriz, hecha con una lista de listas.



 ;;;;;;;;;;;;;;;;;
 ; CONSTRUCTORES ;
 ;;;;;;;;;;;;;;;;;


; Descripción: funcion que crea un tablero de conecta 4.
; Dom: sin parametros de entrada
; Rec: tablero vacio (board)
; Tipo recursión: No aplica

(define (board) '(("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                  ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                  ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                  ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                  ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                  ("( )" "( )" "( )" "( )" "( )" "( )" "( )")))




 ;;;;;;;;;;;;;;;
 ; PERTENENCIA ;
 ;;;;;;;;;;;;;;;



 ;;;;;;;;;;;;;;
 ; SELECTORES ;
 ;;;;;;;;;;;;;;


; Descripción: funcion que retorna la cantidad de filas del tablero conecta 4 menos uno.
; Dom: sin parametros de entrada
; Rec: cantidad-filas (int)
; Tipo recursión: No aplica

(define board-get-filas 5)



; Descripción: funcion que retorna la cantidad de columnas del tablero conecta 4 menos uno.
; Dom: sin parametros de entrada
; Rec: cantidad columnas (int)
; Tipo recursión: No aplica

(define board-get-columnas 6)



; Descripción: funcion que retorna el elemento del tablero dada una fila y una columna.
; Dom: tablero (board) X fila (int) X columna (int)
; Rec: elemento del tablero (string)
; Tipo recursión: No aplica

(define board-get-elem
  (lambda (board fila columna)
    (list-ref (list-ref board fila) columna)))



; Descripción: funcion que retorna la posicion vertical en la que caería la ficha en una columna dada.
; Dom: tablero (board) X columna (int)
; Rec: posicion vertical donde caería la ficha (int)
; Tipo recursión: Cola

(define board-get-fila-baja
  (lambda (tablero columna)

    (define fila-baja-inner
      (lambda (tablero acomulador-fila columna)
        (cond
          [(< acomulador-fila 0) -1]
          [(equal? "( )" (board-get-elem tablero acomulador-fila columna)) acomulador-fila]
          [(fila-baja-inner tablero (sub1 acomulador-fila) columna)])))
    
    (fila-baja-inner tablero board-get-filas columna)))




 ;;;;;;;;;;;;;;;;;
 ; MODIFICADORES ;
 ;;;;;;;;;;;;;;;;;


; Descripción: funcion que modifica un elemento del tablero dada una fila y una columna.
; Dom: board (board) X fila (int) X columna (int) X elem (piece)
; Rec: tablero modificado (board)
; Tipo recursión: No aplica

(define board-set-elem
  (lambda (board fila columna elem)
    (if (or (equal? fila -1) (> columna board-get-columnas) (< columna 0))
        -1
        (list-set board fila (list-set (list-ref board fila) columna elem)))))



; Descripción: funcion que permite realizar una jugada en el tablero.
; Dom: board (board) X column (int) X piece (piece)
; Rec: tablero actualizado (board)
; Tipo recursión: No aplica

(define board-set-play-piece
  (lambda (board column piece)
    (if (equal? (board-get-fila-baja board column) -1)
        -1
        (board-set-elem board (board-get-fila-baja board column) column piece))))




 ;;;;;;;;;
 ; OTROS ;
 ;;;;;;;;;


; Descripción: funcion que permite verificar si se pueden hacer mas jugadas en el tablero, true: si se puede, false: no se puede.
; Dom: board (board)
; Rec: se puede jugar? (boolean)
; Tipo recursión: No aplica

(define board-can-play?
  (lambda (board)
    (list? (member "( )" (first board)))))



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
              [(and (equal? contador 4) (equal? (board-get-elem board fila columna) "(R)")) 1]
              [(and (equal? contador 4) (equal? (board-get-elem board fila columna) "(Y)")) 2]
              [(equal? fila board-get-filas)
               (vertical-win board 0 (add1 columna) 1)]
              [(equal? (board-get-elem board fila columna) (board-get-elem board (add1 fila) columna))
               (vertical-win board (add1 fila) columna (add1 contador))]
              [else (vertical-win board (add1 fila) columna 1)])))

    (vertical-win board 0 0 1)))



; Descripción: funcion que permite verificar si algun jugador ha ganado horizontalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador horizontal.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Natural

(define board-check-horizontal-win
  (lambda (board)

    (define horizontal-win
      (lambda (board fila columna contador)
        (cond
          [(> fila board-get-filas) 0]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) "(R)")) 1]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) "(Y)")) 2]
          [(equal? columna board-get-columnas)
           (horizontal-win board (add1 fila) 0 1)]
          [(equal? (board-get-elem board fila columna) (board-get-elem board fila (add1 columna)))
           (horizontal-win board fila (add1 columna) (add1 contador))]
          [else (horizontal-win board fila (add1 columna) 1)])))

    (horizontal-win board 0 0 1)))



; Descripción: funcion que permite verificar si algun jugador ha ganado diagonalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador diagonal.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Cola/Backtracking

(define board-check-diagonal-win
  (lambda (board)

    (define check-down-der
      (lambda (board fila columna contador)
        (cond
          [(or (< fila 0) (< columna 0) (> fila board-get-filas) (> columna board-get-columnas)) #f]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) "(R)")) 1]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) "(Y)")) 2]
          [(or (> (add1 fila) board-get-filas) (> (add1 columna) board-get-columnas)) #f]
          [(equal? (board-get-elem board fila columna) (board-get-elem board (add1 fila) (add1 columna)))
           (check-down-der board (add1 fila) (add1 columna) (add1 contador))]
          [else #f])))

    (define check-down-izq
      (lambda (board fila columna contador)
        (cond
          [(or (< fila 0) (< columna 0) (> fila board-get-filas) (> columna board-get-columnas)) #f]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) "(R)")) 1]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) "(Y)")) 2]
          [(or (> (add1 fila) board-get-filas) (< (sub1 columna) 0)) #f]
          [(equal? (board-get-elem board fila columna) (board-get-elem board (add1 fila) (sub1 columna)))
           (check-down-izq board (add1 fila) (sub1 columna) (add1 contador))]
          [else #f])))

    
    (define check-all-diagonal
      (lambda (board fila columna)
        (cond
          [(equal? fila 3) 0]
          [(> columna board-get-columnas) (check-all-diagonal board (add1 fila) 0)]
          [(not (equal? (check-down-der board fila columna 1) #f)) (check-down-der board fila columna 1)]
          [(not (equal? (check-down-izq board fila columna 1) #f)) (check-down-izq board fila columna 1)]
          [else (check-all-diagonal board fila (add1 columna))])))

    (check-all-diagonal board 0 0)))



; Descripción: funcion que verifica el estado del tablero usando las ultimas 3 funciones y entrega el posible ganador.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: No aplica

(define board-who-is-winner
  (lambda (board)
    (cond
      [(not (equal? (board-check-vertical-win board) 0)) (board-check-vertical-win board)]
      [(not (equal? (board-check-horizontal-win board) 0)) (board-check-horizontal-win board)]
      [(not (equal? (board-check-diagonal-win board) 0)) (board-check-diagonal-win board)]
      [else 0])))
