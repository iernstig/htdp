;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname designing-world-programs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ex 39, construct car
(require 2htdp/image)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define CAR-COLOR "blue")
(define CAR-WIDTH (+ WHEEL-DISTANCE (* 4 WHEEL-RADIUS)))
(define CAR-BODY-HEIGHT (* WHEEL-RADIUS 2))
(define CAR-COUPE-HEIGHT WHEEL-RADIUS)
(define CAR-BODY
  (rectangle CAR-WIDTH CAR-BODY-HEIGHT "solid" CAR-COLOR))
(define CAR-CANVAS-HEIGHT (+ CAR-BODY-HEIGHT CAR-COUPE-HEIGHT WHEEL-RADIUS))
(define CAR-CANVAS
  (rectangle CAR-WIDTH
             CAR-CANVAS-HEIGHT
             "solid" "white"))
(define CAR-COUPE
  (rectangle WHEEL-DISTANCE WHEEL-RADIUS "solid" CAR-COLOR))



(define CAR (place-image WHEEL (* 2 WHEEL-RADIUS) (+ CAR-COUPE-HEIGHT CAR-BODY-HEIGHT)
             (place-image WHEEL (- CAR-WIDTH (* 2 WHEEL-RADIUS)) (+ CAR-COUPE-HEIGHT CAR-BODY-HEIGHT)
                          (place-image CAR-BODY (/ CAR-WIDTH 2) (/ CAR-CANVAS-HEIGHT 2)
                                       (place-image
                                        CAR-COUPE (/ CAR-WIDTH 2) (/ CAR-COUPE-HEIGHT 2)
                                        CAR-CANVAS)))))

;; EXERCISE 41 - CREATING THE WORLD!
(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 40)
; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car


(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))
; -- Wish List -- ; 
; WorldState: data that represents the state of the world (cw)

; WorldState -> Image
; when needed, big-bang obtains the image of the current
; state of the world by evaluating (render cw)
; (define (render ws) ...)
; place the image of car x pixels from the left marign of the BACKGROUND img
(define (render x)
  BACKGROUND)

; WorldState -> WorldState
; for each tick fo the clock, big-bang obtains the next
; state of the world from (clock-tick-handler cw)
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]))

; WorldState String -> WorldState
; for each keystroke, big-bang obtains the next state
; from (keystroke-handler cw ke); ke represents the key
(define (keystroke-handler cw ke) ...)

; WorldState Number Number String -> WorldState
; fro each mous gesture, big-bang obtains the next
; state from (mouse-event-handler cw x y me) where x and y
; are the coordinates of the event and me is its description
(define (mouse-event-handler cw x y me) ...)

; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw)
(define (end? cw) ...)