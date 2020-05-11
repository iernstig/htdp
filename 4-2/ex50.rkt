;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex50) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)
; Exercise 50
; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "yellow") "red")
(check-expect (traffic-light-next "green") "yellow")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

(define BACKGROUND (empty-scene 100 100))

; Exercise 51 - big-bang program to simulate traffic lights

; Time -> Image
; outputs the current rendering
; of the world for each time step
(define (render s)
  (place-image (circle 50 "solid" s) 50 50 BACKGROUND))


; Main program
(define (traffic-light-sim s)
  (big-bang s
    [on-tick traffic-light-next]
    [to-draw render]))

(traffic-light-sim "red")