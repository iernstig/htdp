;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex43) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; TODO: exercise 43
(require 2htdp/image)
(require 2htdp/universe)

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
             (* 20 WHEEL-RADIUS)
             "outline" "black")))

; moves the y-position of the car from the center to the bottom
(define Y-CAR (* 3 WHEEL-RADIUS));(/ (image-height CAR) 2))
; Number -> Number
; increases the time in the simulatio
(define (tock AnimationState)
  (add1 AnimationState))

(check-expect (tock 190) 191)
(check-expect (tock 19) 20)

;(place-image CAR 100 Y-CAR BACKGROUND)

(define SPEED 5)
; Number -> Number
; obtains the x-distance between the car
; and the left margin of the background
; given clock ticks t
(define (x-distance t)
  (* SPEED t))

; Number -> Number
; obtains the y-dstance between the car
; and the top morgin of the background
; given time clocks t
(define (y-distance t)
  (- (/ (image-height BACKGROUND) 2)
     (* 10 WHEEL-RADIUS (sin t))))

; AnimationState -> Image
; places image on background according
; to current value of the timer
(define (render AnimationState)
  (place-image CAR (x-distance AnimationState) (y-distance AnimationState)
               BACKGROUND))


; AnimationState -> Boolean
; afer each event, big-bang evaluates (end? AnimationState)
; purpose: check if the car is out of the frame
(define (end? AnimationState)
  (> AnimationState (image-width BACKGROUND)))

(define (main AnimationState)
  (big-bang AnimationState
    [on-tick tock]
    [to-draw render]
    [stop-when end?]))