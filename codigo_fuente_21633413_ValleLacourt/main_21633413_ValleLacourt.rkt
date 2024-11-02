#lang racket
(require "TDA-player_21633413_ValleLacourt.rkt")
(require "TDA-piece_21633413_ValleLacourt.rkt")
(require "TDA-board_21633413_ValleLacourt.rkt")
(require "TDA-game_21633413_ValleLacourt.rkt")


;----------------------------------------------------------
; RF02 - TDA Player - constructor
; Descripción: funcion que permite crear un jugador.
; Dom: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining-pieces (int)
; Rec: jugador (player)
; Tipo recursión: No aplica

(define player
  (lambda (id name color wins losses draws remaining-pieces)
    (list id name (piece color) wins losses draws remaining-pieces)))


;----------------------------------------------------------
; RF03 - TDA Piece - constructor
; Descripción: funcion que crea una ficha de conecta 4.
; Dom: color (string)
; Rec: pieza (piece)
; Tipo recursión: No aplica

(define piece
  (lambda (color)
    (cons color (string-upcase (string #\( (string-ref color 0) #\)))) ))


;----------------------------------------------------------
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


;----------------------------------------------------------
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


;----------------------------------------------------------
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


;----------------------------------------------------------
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


;----------------------------------------------------------
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


;----------------------------------------------------------
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


;----------------------------------------------------------
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


;----------------------------------------------------------
; RF11 - TDA Game - constructor
; Descripción: funcion que crea una nueva partida.
; Dom: player1 (player) X player2 (player) X board (board) X current-turn (int)
; Rec: juego (game)
; Tipo recursión: No aplica

(define game
  (lambda (player1 player2 board current-turn)
    (list player1 player2 (board-with-players board player1 player2) current-turn (list))))


;----------------------------------------------------------
; RF12 - TDA Game - otros - history
; Descripción: funcion que genera un historial de movimientos de la partida.
; Dom: game (game)
; Rec: historial (list de pares)
; Tipo recursión: No aplica

(define game-history
  (lambda (game)
    (list-ref game 4)))


;----------------------------------------------------------
; RF13 - TDA Game - otros - esEmpate?
; Descripción: funcion que verifica si el estado del juego es empate. Tablero lleno o jugadores sin fichas.
; Dom: game (game)
; Rec: empate (boolean)
; Tipo recursión: No aplica

(define game-is-draw?
  (lambda (game)
    (if (and
         (or (not (board-can-play? (game-get-board game)))
             (and (equal? (player-get-remaining-pieces (game-get-p1 game)) 0)
                  (equal? (player-get-remaining-pieces (game-get-p2 game)) 0)))
         (equal? (board-who-is-winner (game-get-board game)) 0))
        #t
        #f)))


;----------------------------------------------------------
; RF14 - TDA Player - otros - actualizarEstadisticas
; Descripción: funcion que actualiza las estadisticas del jugador despues de un juego (victoria, derrota o empate).
; Dom: player (player) X result (string: "win" | "loss" | "draw")
; Rec: player actualizado (player)
; Tipo recursión: No aplica

(define player-update-stats
  (lambda (player result)
    (cond
      [(equal? result "win") (player-set-add1-wins player)]
      [(equal? result "loss") (player-set-add1-losses player)]
      [(equal? result "draw") (player-set-add1-draws player)])))


;----------------------------------------------------------
; RF15 - TDA Game - selector - getCurrentPlayer
; Descripción: funcion que obtiene el jugador del turno actual.
; Dom: game (game)
; Rec: jugador del turno actual (player)
; Tipo recursión: No aplica

(define game-get-current-player
  (lambda (game)
    (if (equal? (game-get-current-turn game) 1)
        (game-get-p1 game)
        (game-get-p2 game))))


;----------------------------------------------------------
; RF16 - TDA Game - selector - board-get-state
; Descripción: funcion que entrega el tablero actual.
; Dom: game (game)
; Rec: estado del tablero del juego actual (board)
; Tipo recursión: No aplica

(define game-get-board
  (lambda (game) (list-ref game 2)))


;----------------------------------------------------------
; RF17 - TDA Game - modificador - game-set-end
; Descripción: funcion que finaliza el juego, actualizando las estadisticas de los jugadores.
; Dom: Game (game)
; Rec: juego terminado (game)
; Tipo recursión: No aplica

(define game-set-end
  (lambda (Game)
    
    (cond
      [(equal? (board-who-is-winner (game-get-board Game)) 1)
       (game-with-history (game
                          (player-update-stats (game-get-p1 Game) "win")
                          (player-update-stats (game-get-p2 Game) "loss")
                          (game-get-board Game)
                          (game-get-current-turn Game))
                         Game
                         null)]

      [(equal? (board-who-is-winner (game-get-board Game)) 2)
       (game-with-history (game
                          (player-update-stats (game-get-p1 Game) "loss")
                          (player-update-stats (game-get-p2 Game) "win")
                          (game-get-board Game)
                          (game-get-current-turn Game))
                         Game
                         null)]

      [(equal? (board-who-is-winner (game-get-board Game)) 0)
       (game-with-history (game
                          (player-update-stats (game-get-p1 Game) "draw")
                          (player-update-stats (game-get-p2 Game) "draw")
                          (game-get-board Game)
                          (game-get-current-turn Game))
                         Game
                         null)])))


;----------------------------------------------------------
; RF18 - TDA Game - modificador - realizarMovimiento
; Descripción: funcion que realiza un movimiento.
; Dom: Game (game) X player (player) X column (int)
; Rec: juego actualizado (game)
; Tipo recursión: No aplica

(define game-player-set-move
  (lambda (Game player column)
    (cond
      [(equal? (board-set-play-piece (game-get-board Game) column (player-get-piece player)) #f) Game]  ;si la jugada es imposible devolver el juego sin cambios
      [(and (equal? (game-get-current-turn Game) 1)
            (equal? (player-get-id player) (player-get-id (game-get-p1 Game))))  ;si el turno es de p1 y juega p1...

       (if (or (game-is-draw? (jugada-p1 Game player column))
               (equal? (board-who-is-winner (game-get-board (jugada-p1 Game player column))) 1))  ;si es empate o victoria...
           (game-set-end (jugada-p1 Game player column))             ;declarar fin
           (jugada-p1 Game player column))]                          ;sino, devolver nueva jugada

      [(and (equal? (game-get-current-turn Game) 2)
            (equal? (player-get-id player) (player-get-id (game-get-p2 Game)))) ;si el turno es de p2 y juega p2...

       (if (or (game-is-draw? (jugada-p2 Game player column))
               (equal? (board-who-is-winner (game-get-board (jugada-p2 Game player column))) 2))   ;si es empate o victoria...     
           (game-set-end (jugada-p2 Game player column))             ;declarar fin    
           (jugada-p2 Game player column))]                          ;sino, devolver nueva jugada

      [else Game])))  ;si el turno es incorrecto devuelve el juego sin cambios

