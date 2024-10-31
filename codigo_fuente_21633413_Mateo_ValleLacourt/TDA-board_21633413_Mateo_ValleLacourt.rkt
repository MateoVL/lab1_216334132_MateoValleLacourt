#lang racket
(require "TDA-player_21633413_Mateo_ValleLacourt.rkt")
(require "TDA-piece_21633413_Mateo_ValleLacourt.rkt")

(provide board)
(provide board-with-players)
(provide board-get-tablero)
(provide board-get-fila-baja)
(provide board-get-p1)
(provide board-get-p2)
(provide board-get-filas)
(provide board-get-columnas)
(provide board-get-elem)
(provide board-set-elem)
(provide board-set-play-piece)
(provide board-can-play?)
(provide board-check-vertical-win)
(provide board-check-horizontal-win)
(provide board-check-diagonal-win)
(provide board-who-is-winner)


;;;TDA board: Estructura que representa un tablero 6x7 de conecta 4 en base de una matriz, hecha con una lista de listas. Tambien tiene a jugador 1 y 2 de un juego.



 ;;;;;;;;;;;;;;;;;
 ; CONSTRUCTORES ;
 ;;;;;;;;;;;;;;;;;


; RF04 - TDA Board - constructor
; Descripción: funcion que crea un tablero de conecta 4.
; Dom: sin parametros de entrada
; Rec: tablero vacio (board)
; Tipo recursión: No aplica

(define (board) (list '(("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                        ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                        ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                        ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                        ("( )" "( )" "( )" "( )" "( )" "( )" "( )")
                        ("( )" "( )" "( )" "( )" "( )" "( )" "( )")) '() '()))



; Descripción: funcion que crea la representacion de tablero con el tablero, jugador 1 y 2.
; Dom: board (board) X p1 (player) X p2 (player)
; Rec: Representacion de tablero (board)
; Tipo recursión: No aplica

(define board-with-players
  (lambda (board p1 p2)
    (list-set (list-set board 1 p1) 2 p2)))




 ;;;;;;;;;;;;;;;
 ; PERTENENCIA ;
 ;;;;;;;;;;;;;;;



 ;;;;;;;;;;;;;;
 ; SELECTORES ;
 ;;;;;;;;;;;;;;


; Descripción: funcion que retorna el tablero del TDA board.
; Dom: board (board)
; Rec: tablero (list)
; Tipo recursión: No aplica

(define board-get-tablero
  (lambda (board) (car board)))



; Descripción: funcion que retorna el jugador 1 de board.
; Dom: board (board)
; Rec: p1 (player)
; Tipo recursión: No aplica

(define board-get-p1
  (lambda (board) (cadr board)))



; Descripción: funcion que retorna el jugador 2 de board.
; Dom: board (board)
; Rec: p2 (player)
; Tipo recursión: No aplica

(define board-get-p2
  (lambda (board) (caddr board)))



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
    (list-ref (list-ref (board-get-tablero board) fila) columna)))



; Descripción: funcion que retorna la posicion vertical en la que caería la ficha en una columna dada.
; Dom: tablero (board) X columna (int)
; Rec: posicion vertical donde caería la ficha (int)
; Tipo recursión: Cola

(define board-get-fila-baja
  (lambda (board columna)

    (define fila-baja-inner
      (lambda (board acomulador-fila columna)
        (cond
          [(< acomulador-fila 0) -1]
          [(equal? "( )" (board-get-elem board acomulador-fila columna)) acomulador-fila]
          [(fila-baja-inner board (sub1 acomulador-fila) columna)])))
    
    (fila-baja-inner board board-get-filas columna)))




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
        (list-set board 0 (list-set (board-get-tablero board) fila (list-set (list-ref (board-get-tablero board) fila) columna elem))))))



; RF06 - TDA Board - modificador - jugar ficha
; Descripción: funcion que permite realizar una jugada en el tablero.
; Dom: board (board) X column (int) X piece (piece)
; Rec: tablero actualizado (board)
; Tipo recursión: No aplica

(define board-set-play-piece
  (lambda (board column piece)
    (if (or (equal? (board-get-fila-baja board column) -1) (equal? (board-can-play? board) #f))
        #f
        (board-set-elem board (board-get-fila-baja board column) column (piece-get-piece piece)))))




 ;;;;;;;;;
 ; OTROS ;
 ;;;;;;;;;


; RF05 - TDA Board - otros - sePuedeJugar?
; Descripción: funcion que permite verificar si se pueden hacer mas jugadas en el tablero, true: si se puede, false: no se puede.
; Dom: board (board)
; Rec: se puede jugar? (boolean)
; Tipo recursión: No aplica

(define board-can-play?
  (lambda (board)
    (if (equal? (board-who-is-winner board) 0)
        (list? (member "( )" (first (board-get-tablero board))))
        #f)))



; RF07 - TDA Board - otros - verificar victoria vertical
; Descripción: funcion que permite verificar si algun jugador ha ganado verticalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Natural, ya que no usa contadores y la solucion se va resolviendo a medida que se avanza en el tablero, dejando estados pendientes.

(define board-check-vertical-win
  (lambda (board)
    (define transponer-tablero   ;rota el tablero en 90 grados
      (lambda (tablero)
        (if (null? (car tablero)) 
            '()
            (cons (map car tablero) (transponer-tablero (map cdr tablero))))))
    
    (define verificar-columna
      (lambda (lista p1 p2)
        (cond
          [(equal? (length lista) 3) 0]   ;si el tamaño es 3, retornar 0, ya que no pueden haber 4 seguidas
          [(and (equal? (car lista) (cadr lista))  ;sino, si las sig 4 pos son iguales y son piezas de p1, retornar 1.
                (equal? (cadr lista) (caddr lista))
                (equal? (caddr lista) (cadddr lista))
                (equal? (car lista) (piece-get-piece (player-get-piece p1)))) 1]

          [(and (equal? (car lista) (cadr lista)) ;sino, vericiar con la pieza de p2
                (equal? (cadr lista) (caddr lista))
                (equal? (caddr lista) (cadddr lista))
                (equal? (car lista) (piece-get-piece (player-get-piece p2)))) 2]
          [else (verificar-columna (cdr lista) p1 p2)]))) ;sino son iguales, avanzo en la lista
   

    (if (equal? (length (transponer-tablero (reverse (board-get-tablero board)))) 1) ;si se llega a la ultima columna, sumar verificar columna y 0, si no
        (+ (verificar-columna
            (car (transponer-tablero (reverse (board-get-tablero board))))
            (board-get-p1 board)
            (board-get-p2 board)) 0)

        (+ (verificar-columna    ;sino, sumar verificar columna con el llamado recursivo de la siguiente columna
            (car (transponer-tablero (reverse (board-get-tablero board))))
            (board-get-p1 board)
            (board-get-p2 board))
           (board-check-vertical-win (board-with-players
                                      (list-set board 0 (reverse
                                                         (transponer-tablero (cdr (transponer-tablero (reverse
                                                                                                       (board-get-tablero board)))))))
                                      (board-get-p1 board)
                                      (board-get-p2 board)))))))

;ejemplo: (+ ganador-de-columna (+ ganador-de-columna-sig (+ ganador-de-columna-sig 0)))
;si la suma es 1 es porq encontro victoria de p1
;si la suma es 2 es porq encontro victoria de p2
;si la suma es 0 es porq no se encontro ganadores



; RF08 - TDA Board - otros - verificar victoria horizontal
; Descripción: funcion que permite verificar si algun jugador ha ganado horizontalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador horizontal.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Natural, ya que no usa contadores y la solucion se va resolviendo a medida que se avanza en el tablero, dejando estados pendientes.

(define board-check-horizontal-win
  (lambda (board)

    (define verificar-fila
      (lambda (lista p1 p2)
        (cond
          [(equal? (length lista) 3) 0]
          [(and (equal? (car lista) (cadr lista))
                (equal? (cadr lista) (caddr lista))
                (equal? (caddr lista) (cadddr lista))
                (equal? (car lista) (piece-get-piece (player-get-piece p1)))) 1]

          [(and (equal? (car lista) (cadr lista))
                (equal? (cadr lista) (caddr lista))
                (equal? (caddr lista) (cadddr lista))
                (equal? (car lista) (piece-get-piece (player-get-piece p2)))) 2]
          [else (verificar-fila (cdr lista) p1 p2)])))

    
    (if (null? (board-get-tablero board)) 0
        (+ (verificar-fila
            (car (board-get-tablero board))
            (board-get-p1 board)
            (board-get-p2 board))
           (board-check-horizontal-win (board-with-players
                                        (list-set board 0 (cdr (board-get-tablero board)))
                                        (board-get-p1 board)
                                        (board-get-p2 board)))))))

;ejemplo: (+ ganador-de-fila (+ ganador-de-fila-sig (+ ganador-de-fila-sig 0)))
;si la suma es 1 es porq encontro victoria de p1
;si la suma es 2 es porq encontro victoria de p2
;si la suma es 0 es porq no se encontro ganadores



; RF09 - TDA Board - otros - verificar victoria diagonal
; Descripción: funcion que permite verificar si algun jugador ha ganado diagonalmente. 1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador diagonal.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: Cola, "board-check-diagonal-win" es un wrapper para la funcion "check-diagonal-inner", que usa recursion de cola para llegar al resultado,
; usando las funciones check-down-izq y der, las cuales calculan quien es ganador, dada una pocision, llendose diagonalmente hacia las direcciones dadas.
; Por lo tanto, al no dejar estado pendientes, ya que la respuesta parcial se la lleva el acomulador, siendo este el que se entrega al finalizar de escanear el tablero,
; se dice que es de recursividad de tipo cola.

(define board-check-diagonal-win
  (lambda (board)

    (define check-down-der
      (lambda (board fila columna contador)
        (cond
          [(or (< fila 0) (< columna 0) (> fila board-get-filas) (> columna board-get-columnas)) 0]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) (piece-get-piece (player-get-piece (board-get-p1 board))))) 1]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) (piece-get-piece (player-get-piece (board-get-p2 board))))) 2]
          [(or (> (add1 fila) board-get-filas) (> (add1 columna) board-get-columnas)) 0]
          [(equal? (board-get-elem board fila columna) (board-get-elem board (add1 fila) (add1 columna)))
           (check-down-der board (add1 fila) (add1 columna) (add1 contador))]
          [else 0])))

    (define check-down-izq
      (lambda (board fila columna contador)
        (cond
          [(or (< fila 0) (< columna 0) (> fila board-get-filas) (> columna board-get-columnas)) 0]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) (piece-get-piece (player-get-piece (board-get-p1 board))))) 1]
          [(and (equal? contador 4) (equal? (board-get-elem board fila columna) (piece-get-piece (player-get-piece (board-get-p2 board))))) 2]
          [(or (> (add1 fila) board-get-filas) (< (sub1 columna) 0)) 0]
          [(equal? (board-get-elem board fila columna) (board-get-elem board (add1 fila) (sub1 columna)))
           (check-down-izq board (add1 fila) (sub1 columna) (add1 contador))]
          [else 0])))

    (define check-diagonal-inner
      (lambda (board fila columna acomulador)
       
          (if (equal? fila 3)
              acomulador
              (if (> columna board-get-columnas)
                  (check-diagonal-inner board (add1 fila) 0 acomulador)
                  (check-diagonal-inner board fila (add1 columna) (+ acomulador
                                                                 (check-down-der board fila columna 1)
                                                                 (check-down-izq board fila columna 1)))))))

    (check-diagonal-inner board 0 0 0)))



; RF10 - TDA Board - otros - entregarGanador
; Descripción: funcion que verifica el estado del tablero usando las ultimas 3 funciones y entrega el posible ganador,
; se usa esta estructura, ya que si simplemente sumamos los resultados de las 3 funciones, pueden haber casos especiales en los cuales,
; un jugador, al poner una pieza, pueda ganar en mas de una forma.
; Dom: board (board)
; Rec: 1 (int) | 2 (int) | 0 (int)
; Tipo recursión: No aplica

(define board-who-is-winner
  (lambda (board)
    (cond
      [(or (equal? (board-get-p1 board) '()) (equal? (board-get-p2 board) '())) 0]
      [(not (equal? (board-check-vertical-win board) 0)) (board-check-vertical-win board)]
      [(not (equal? (board-check-horizontal-win board) 0)) (board-check-horizontal-win board)]
      [(not (equal? (board-check-diagonal-win board) 0)) (board-check-diagonal-win board)]
      [else 0])))
