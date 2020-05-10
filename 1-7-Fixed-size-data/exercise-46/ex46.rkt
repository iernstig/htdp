;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex46) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; CAR DEFINITION
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 4))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define BOTH-WHEELS
  (overlay/xy WHEEL
              (* 4 WHEEL-RADIUS)
              0
              WHEEL))

(define CAR-MIDDLE
  (rectangle WHEEL-DISTANCE
             (* 3 WHEEL-RADIUS) "solid" "red"))
(define CAR-BOTTOM
  (rectangle (* 8 WHEEL-RADIUS)
             (* 2 WHEEL-RADIUS)
             "solid" "red"))
(define CAR-BODY
  (overlay/xy CAR-MIDDLE
           (- (* 2 WHEEL-RADIUS))
           WHEEL-RADIUS
           CAR-BOTTOM))
(define CAR
  (overlay/xy BOTH-WHEELS
              (- WHEEL-RADIUS)
              (- (* WHEEL-RADIUS 2))
              CAR-BODY))

(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))


(define BACKGROUND
  (place-image tree (* 30 WHEEL-RADIUS) (* 3 WHEEL-RADIUS)
  (rectangle (* 50 WHEEL-RADIUS)
             (* 5 WHEEL-RADIUS)
             "outline" "black")))
                               

; move point of origin of car from middle to bottom edge
(define Y-CAR (* 3 WHEEL-RADIUS))
(define SPEED 5)

; initial wish-list, caused by big-bang deƒ:
; WorldState -> Image
; place image of car x pix from l-margin of BACKGROUND img.
(define (render ws)
  (place-image CAR ws Y-CAR BACKGROUND))

; WorldState -> WorldState
; adds 3 to x to move the car right
; examples:
; give 20 expect 23
; give 82 expect 85
(define (tock ws)
  (+ ws SPEED))

(check-expect (tock 10) (+ 10 SPEED))
(check-expect (tock 13) (+ 13 SPEED))

; key-stroke-handler
; WorldState String -> WorldState
; for each key stroke, re initiate world to 0
(define (stroke ws ke)
  0)

; WorldState -> Boolean
; when the car has disappeared on right far edge
; stop the animation!
; examples:
; input 250 -> True
; input 20 -> False
(define (end? ws)
  (> (- ws (/ (image-width CAR) 2))
  (image-width BACKGROUND)))
(check-expect (end? 300) #true)
(check-expect (end? 20) #false)
                          

; you need a main function!
; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [on-key stroke]
    [stop-when end?]))

