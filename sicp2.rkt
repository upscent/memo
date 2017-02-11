#lang racket

(define (average x y)
  (/ (+ x y) 2))

;Q2.1
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat n d)
  (let ((g (gcd (abs n) (abs d))))
    (if (> d 0)
        (cons (/ n g) (/ d g))
        (cons (/ (- n) g) (/ (- d) g)))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (add-rat x y)
  (make-rat (+ (* numer x) (denom y)
               (* numer y) (denom x))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* numer x) (denom y)
               (* numer y) (denom x))
            (* (denom x) (denom y))))

; Q2.2

(define (make-point x y)
  (cons x y))

(define (x-point x) (car x))

(define (y-point x) (cdr x))

(define (midpoint x y)
  (make-point
   (average (x-point x) (x-point y))
   (average (y-point x) (y-point y))))

(define (make-segment start end)
  (cons start end))

(define (start-segment x) (car x))

(define (end-segment x) (cdr x))

(define (midpoint-segment x)
  (midpoint (start-segment x) (end-segment x)))

; Q2.3

(define (make-rect x y)
  (cons x y))

(define (first-point x) (car x))

(define (second-point x) (cdr x))

(define (x-length rect)
  (abs (- (x-point (first-point rect)) (x-point (second-point rect)))))

(define (y-length rect)
  (abs (- (y-point (first-point rect)) (y-point (second-point rect)))))

(define (perimeter rect)
  (* 2 (+ (x-length rect) (y-length rect))))

(define (area rect)
  (* (x-length rect) (y-length rect)))

;------------------------------

(define (make-rect2 point x-length y-length)
  (cons point (cons x-length y-length)))

(define (first-point2 rect) (car rect))

(define (second-point2 rect)
  (make-point
   (+ (x-point (first-point2 rect)) (x-length rect))
   (+ (y-point (first-point2 rect)) (y-length rect))))

(define (x-length2 rect) (car (cdr rect)))

(define (y-length2 rect) (cdr (cdr rect)))

(define (perimeter2 rect)
  (* 2 (+ (x-length2 rect) (y-length2 rect))))

(define (area2 rect)
  (* (x-length2 rect) (y-length2 rect)))

; Q2.4

;(define (cons x y)
;  (lambda (m) (m x y)))

;(define (car z)
;  (z (lambda (p q) p)))

;(define (cdr z)
;  (z (lambda (p q) q)))

; Q2.5

(define (cons2 x y)
  (* (expt  2 x) (expt 3 y)))

(define (car2 z)
  (define (itr z ans)
    (if (= 0 (remainder z 2))
        (itr (/ z 2) (+ ans 1))
        ans))
  (itr z 0))

(define (cdr2 z)
  (define (itr z ans)
    (if (= 0 (remainder z 3))
        (itr (/ z 3) (+ ans 1))
        ans))
  (itr z 0))

; Q2.6

(define zero
  (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one
  (lambda (f) (lambda (x) (f x))))

(define two
  (lambda (f) (lambda (x) (f (f x)))))

(define (plus m n)
  ((m add-1) n))

;---------------------
; 2.1.4
;---------------------

(define (print-center-percent i)
  (display "center:  ")
  (display (center i))
  (display "\npercent: ")
  (display (percent i)))

; Q2.7

(define (make-interval a b)
   (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

; Q2.8

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (lower-bound y))
                 (- (upper-bound x) (upper-bound y))))

; Q2.9
; 1 2 3  3 4 5  2  2
; multi
; 1,2,3  3,4,5  3,9,15
; 1,2,3  2,3,4  2,7,12
; div
; 6,7,8  2,3,4  2,2.5,3
; 10,11,12  2,3,4  3,4,5

; Q2.10
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (< (* (upper-bound y) (lower-bound y)) 0)
      (error "interval spans zero")
      (mul-interval x (make-interval (/ 1.0 (upper-bound y))
                          (/ 1.0 (lower-bound y))))))

; (-, -) (+, +) = (min1 * min2, max1 * max2)
; (-, +) (+, +) = (min1 * max2, max1 * max2)
; (-, +) (-, +) = ((min1 * min2) or (max1 * max2),
;                  (min1 * max2) or (max2 * min1)))
;

; Q2.11
; メモにて場合分け完了
; + + + +
; - + + +
; + + - +
; - - + +
; - + - + ← 乗算4回必要
; + + - -
; - - - +
; - + - -
; - - - -

; Q2.12

(define (make-center-percent c p)
  (define w (* c (/ p 100.0)))
  (make-interval (- c w) (+ c w)))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (percent i)
  (* (/ (width i) (center i)) 100.0))

; Q2.14

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

; Q2.25
; (car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))
; (car (car '((7))))
; (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr '(1 (2 (3 (4 (5 (6 7))))))))))))))))))

; Q2.26
; (define x '(1 2 3))
; (define y '(4 5 6))

; (append x y)
; => '(1 2 3 4 5 6)
; (cons x y)
; => '((1 2 3) 4 5 6)
; (list x y)
; => '((1 2 3) (4 5 6))

; Q2.27
(define (deep-reverse x)
  (if (pair? x)
      (append (deep-reverse (cdr x)) (list (deep-reverse (car x))))
      x))

; Q2.28
(define (fringe x)
  (if (pair? x)
      (if (null? (cdr x))
          (fringe (car x))
          (append (fringe (car x)) (fringe (cdr x))))
      (list x)))

;-------------------------
; Q2.29
;-------------------------
(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

;-------------------------
; Q2.29 a
;-------------------------
(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (car (cdr mobile)))
(define (branch-length branch) (car branch))
(define (branch-structure branch)
  (car (cdr branch)))

;-------------------------
; Q2.29 b
;-------------------------
(define (total-weight mobile)
  (if (pair? mobile)
      (+
       (total-weight (branch-structure (left-branch mobile)))
       (total-weight (branch-structure (right-branch mobile))))
      mobile))

;-------------------------
; Q2.29 c
;-------------------------
(define (balanced? mobile)
  ; バランスが取れている場合はpositive、そうでない場合は0を返す
  (define (balanced-weight mobile)
    (if (pair? mobile)
        (let ((left-balanced-weight
               (balanced-weight (branch-structure (left-branch mobile))))
              (right-balanced-weight
               (balanced-weight (branch-structure (right-branch mobile)))))
          (if (and
               (positive? left-balanced-weight)
               (positive? right-balanced-weight)
               (equal?
                (* left-balanced-weight (branch-length (left-branch mobile)))
                (* right-balanced-weight (branch-length (right-branch mobile)))))
              (+ left-balanced-weight right-balanced-weight)
              0))
        mobile))
  (positive? (balanced-weight mobile)))

;ex
(define balanced-mobile
  (make-mobile
   (make-branch 10 2)
   (make-branch 20 1)))
(define not-balanced-mobile
  (make-mobile
   (make-branch 10 2)
   (make-branch 20 1)))

;-------------------------
; Q2.29 d
;-------------------------
; Q2.29 a だけ変更すれば良い

;-------------------------
; Q2.30
;-------------------------
(define (square-tree-1 tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (expt tree 2))
        (else (cons (scale
(define (square-tree-2 tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (expt sub-tree 2)))
       tree))
;ex
(define q2-30-ex-input
  (list 1
        (list 2
              (list 3
                    4)
              5)
        (list 6
              7)))
; > (square-tree q2-30-ex-input)
; '(1 (4 (9 16) 25) (36 49))
