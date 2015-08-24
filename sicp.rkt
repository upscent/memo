#lang racket

; Q1.10
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))
(define (f n) (A 0 n))
(define (g n) (A 1 n))
(define (h n) (A 2 n))

; Q1.11
; 再起的プロセス
(define (f-1-11 n)
  (cond ((< n 3) n)
        (else    (+ (f-1-11 (- n 1))
                    (* 2 (f-1-11 (- n 2)))
                    (* 3 (f-1-11 (- n 3)))))))

; 反復的プロセス
(define (f-1-11- n)
  (if (< n 3) n
      (f-1-11-iter 2 1 0 (- n 2))))
(define (f-1-11-iter f-1 f-2 f-3 count)
  (if (= count 0)
      f-1
      (f-1-11-iter
       (+ f-1 (* 2 f-2) (* 3 f-3))
       f-1
       f-2
       (- count 1))))

; Q1.12

(define (pascal n m)
  (cond ((= m 0) 1)
        ((= m n) 19)
        (else (+ (pascal (- n 1) (- m 1))
                 (pascal (- n 1) m)))))

; Q1.13

(define (fib n) (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))

; Q1.15
; a. 6回
; b.

; Q1.16

(define (fast-expt2 n b)
  (fast-expt-iter n b 1))

(define (fast-expt-iter n b a)
  (cond ((= n 0) a)
        ((even? n) (* a
                      (* 2 (fast-expt-iter (/ n 2) b ))))
        (else (fast-expt-iter (- n 1) b (* a b)))))
                   
(define (even? n)
  (= (remainder n 2) 0))

(define (square n)
  (* n n))

; Q1.17

(define (double n) (* 2 n))

(define (halve n) (/ n 2))

(define (fast-mult a b)
  (cond ((or (= a 0) (= b 0)) 0)
        ((even? b) (fast-mult (double a) (halve b)))
        (else (+ a (fast-mult a (- b 1))))))

; Q1.18

(define (fast-mult2 a b)
  (fast-mult-iter a b 0))

(define (fast-mult-iter a b n)
  (cond ((= b 1)   (+ n a))
        ((even? b) (fast-mult-iter (double a) (halve b) n))
        (else      (fast-mult-iter a (- b 1) (+ n a)))))

; Q1.19

; Q1.20

; 作用的順序
; (gcd 206 40)
; (gcd 40 6)
; (gcd 6 4)
; (gcd 4 2)
; (gcd 2 0)
; 2

; 正規順序
; (gcd 206 40)
; (gcd 40 (remainder 206 40))
; (gcd 40 (remainder 206 40))

; Q1.21

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

; Q1.22

(define (timed-prime-test n)
  (display n)
  (newline)
  (define start-time (current-milliseconds))
  (define is-prime (prime? n))
  (define end-time (current-milliseconds))
  (define runtime (- end-time start-time))
  (display (if is-prime
               (string-append
                        "***"
                        " "
                        (number->string (- end-time start-time)))
                "")))

(define (prime? n)
  (= n (smallest-divisor n)))

; Q1.23

(define (prime2? n)
  (= n (smallest-divisor2 n)))

(define (smallest-divisor2 n)
  (find-divisor2 n 2))

(define (find-divisor2 n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (next test-divisor)
  (cond ((= test-divisor 2) 3)
        (else               test-divisor + 2)))

; Q1.24

(define (timed-prime-test3 n)
  (display n)
  (newline)
  (define start-time (current-milliseconds))
  (define is-prime (fast-prime? n 10000))
  (define end-time (current-milliseconds))
  (define runtime (- end-time start-time))
  (display (if is-prime
               (string-append
                        "***"
                        " "
                        (number->string (- end-time start-time)))
                "")))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (big-random (- n 1))))

(define (big-random n)
  (inexact->exact (ceiling (* n (random)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

; 1.27

(define (all-fermat-test n)
  (try-it-iter (- n 1) n))

(define (try-it-iter a n)
  (cond ((= a 0) true)
        ((= (expmod a n n) a) (try-it-iter (- a 1) n))
        (else a)))

; 1,28

(define (is-prime-by-miller-rabin-test? n)
  (define (is-prime-iter times)
    (cond ((= times 0) true)
          ((miller-rabin-test n) (is-prime-by-miller-rabin-test? n (- times 1)))
          (else false)))
  (is-prime-iter 10))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (define (is-sqrt-mod-n? a)
    (and
     (not (= a 1))
     (not (= a (- n 1)))
     (= (remainder (square a) n) 1)))
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((is-sqrt-mod-n? base) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m)) m))
          (else
           (remainder (* base (expmod base (- exp 1) m)) m))))
  (try-it (big-random (- n 1))))