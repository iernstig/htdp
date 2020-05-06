;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname designing-world-programs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ex 39, construct car
(require 2htdp/image)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define CAR-COLOR "red")
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



(place-image WHEEL (* 2 WHEEL-RADIUS) (+ CAR-COUPE-HEIGHT CAR-BODY-HEIGHT)
             (place-image WHEEL (- CAR-WIDTH (* 2 WHEEL-RADIUS)) (+ CAR-COUPE-HEIGHT CAR-BODY-HEIGHT)
                          (place-image CAR-BODY (/ CAR-WIDTH 2) (/ CAR-CANVAS-HEIGHT 2)
                                       (place-image
                                        CAR-COUPE (/ CAR-WIDTH 2) (/ CAR-COUPE-HEIGHT 2)
                                        CAR-CANVAS))))

;; DEFINING THE WORLD(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 40)
;(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))