;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |47|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 47 - Happiness gauge program
(require 2htdp/universe)
(require 2htdp/image)

(define MAX_HAPPINESS 100)
(define GAUGE_HEIGHT 20)
(define WORLD_CANVAS (empty-scene MAX_HAPPINESS GAUGE_HEIGHT))

; HappinessScore is a number
; which keeps track of the
; happiness in the world

; HappinessScore -> Image
; render correct size rectangle for each
; state of happiness, i.e. create a happiness gauge!
(define (render hs)
  (place-image
   (rectangle hs GAUGE_HEIGHT "solid" "red")
   0 (/ GAUGE_HEIGHT 2)
   WORLD_CANVAS))

; KeyEvent HappinessScore -> HappinesScore
; if the down key is pressed
; -> increase happiness by 1/5
; if the up key is pressed
; -> increase happiness by 1/3
; examples:
; hs: 1 ke: "up" -> hs: 1.3
; hs: 90 ke: "down" -> hs: 90.2
; hs: MAX_HAPPINESS: ke "down" -> hs: MAX_HAPPINESS
; hs: 10: ke: "~" -> hs 10
(define (on-key-handler hs ke)
  (cond [(= (string-length ke) 1) hs]
        [(string=? ke "down") (min (+ hs 0.2) MAX_HAPPINESS)]
        [(string=? ke "up") (min (+ hs 0.3) MAX_HAPPINESS)]))

(check-expect (on-key-handler 1 "up") 1.3)
(check-expect (on-key-handler 90 "down") 90.2)
(check-expect (on-key-handler MAX_HAPPINESS "down") MAX_HAPPINESS)
(check-expect (on-key-handler 10 "~") 10)


; HappinessScore -> HappinessScore
; keep track of happiness score, decrease with 0.1
; for each new world state
; never let happiness go beneath 0
(define (tock hs)
  (max (- hs 0.1) 0))


; HappinessScore -> HappinessScore
; Launch World simulation
(define (gauge-prog hs)
       (big-bang hs
         [on-tick tock]
         [to-draw render]
         [on-key on-key-handler]))