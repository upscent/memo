#lang racket

(define (average x y) (/ (+ x y) 2))

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

(define (halve n) (/ n 2))

(define (fast-mult a b)
  (define (double n) (* 2 n))
  (cond ((or (= a 0) (= b 0)) 0)
        ((even? b) (fast-mult (double a) (halve b)))
        (else (+ a (fast-mult a (- b 1))))))

; Q1.18

(define (fast-mult2 a b)
  (fast-mult-iter a b 0))

(define (fast-mult-iter a b n)
  (define (double n) (* 2 n))
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
          ((miller-rabin-test n) (is-prime-by-miller-rabin-test? (- times 1)))
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

; 1.29

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (yk k) (f (+ a (* k h))))
  (define (term x)
    (cond ((or (= x 0) (= x n)) (yk x))
          ((even? x) (* 2.0 (yk x)))
          (else (* 4.0 (yk x)))))
  (define (next x) (+ x 1))
  (* (/ h 3) (sum term 0 next n)))

(define (cube x) (* x x x))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

; 1.30

(define (sum1 term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

; 1.31

(define (product1 term a next b)
  (if (> a b)
      1
      (* (term a) (product1 term (next a) next b))))

(define (product2 term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* result (term a)))))
  (iter a 1))

(define (factorial n)
  (define (identity x) x)
  (define (iter x) (+ x 1))
  (product2 identity 1 iter n))

; 1.32

(define (accumulate1 combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner
       (term a)
       (accumulate1 combiner null-value term (next a) next b))))

(define (accumulate2 combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))

; 1.33

(define (filtered-accumulate1 combiner null-value term a next b filter)
  (if (> a b)
      null-value
      (if (filter a)
          (combiner
           (term a)
           (filtered-accumulate1 combiner null-value term (next a) next b filter))
          (filtered-accumulate1 combiner null-value term (next a) next b filter))))

(define (sum-squared-prime a b)
  (define (square x) (* x x))
  (define (inc x) (+ x 1))
  (filtered-accumulate1 + 0 square a inc b prime?))

; prime hen dayo!!!! naoshi tai yo!!!!!

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (sum-disjoint-num n)
  (define (inc x) (+ x 1))
  (define (filter x) (= (gcd x n) 1))
  (filtered-accumulate1 * 1 identity 1 inc (- n 1) filter))

; 1.34

(define (f-1-34 g) (g 2))

; application: not a procedure;
; expected a procedure that can be applied to arguments
; given: 2
; arguments.:

; 1.35

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define tolerance 0.00001)

; 1.36

(define (fixed-point2 f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
           next
           (try next))))
  (try first-guess))

;> (fixed-point2 (lambda (x) (/ (log 1000) (log x))) 1.1)
;1.1
;72.47657378429035
;1.6127318474109593
;14.45350138636525
;2.5862669415385087
;7.269672273367045
;3.4822383620848467
;5.536500810236703
;4.036406406288111
;4.95053682041456
;4.318707390180805
;4.721778787145103
;4.450341068884912
;4.626821434106115
;4.509360945293209
;4.586349500915509
;4.535372639594589
;4.568901484845316
;4.546751100777536
;4.561341971741742
;4.551712230641226
;4.558059671677587
;4.55387226495538
;4.556633177654167
;4.554812144696459
;4.556012967736543
;4.555220997683307
;4.555743265552239
;4.555398830243649
;4.555625974816275
;4.555476175432173
;4.555574964557791
;4.555509814636753
;4.555552779647764
;4.555524444961165
;4.555543131130589
;4.555530807938518
;4.555538934848503

;> (fixed-point2 (lambda (x) (/ (+ (/ (log 1000) (log x)) x) 2)) 1.1)
;1.1
;36.78828689214517
;19.352175531882512
;10.84183367957568
;6.870048352141772
;5.227224961967156
;4.701960195159289
;4.582196773201124
;4.560134229703681
;4.5563204194309606
;4.555669361784037
;4.555558462975639
;4.55553957996306
;4.555536364911781

; 1.37

(define (cont-frac n d k) (cont-frac2 n d k))

(define (cont-frac1 n d k)
  (define (cont-frac-iter i result)
    (let ((result-i (/ (n i) (+ (d i) result))))
      (if (= i 1)
           result-i
           (cont-frac-iter (- i 1) result-i))))
  (cont-frac-iter k 0))

; saiki okasi----!!!!!!!
(define (cont-frac2 n d k)
  (define (cont-frac-sub i)
    (if (= i k)
        0
        (/ (n i) (+ (d i) (cont-frac2 n d (- i 1))))))
  (cont-frac-sub k))

; 1.38

(define (cont-frac-euler k)
  (cont-frac
   (lambda (i) 1.0)
   (lambda (i)
     (if (= 2 (remainder i 3)) (* 2 (quotient (+ i 1) 3)) 1))
   k))

; 1.39

(define (tan-cf x k)
  (cont-frac
   (lambda (i) (* -1 (if (= i 1) x (* x x))))
   (lambda (i) (-  (* 2 i) 1))
   k))

; 1.40

(define dx 0.00001)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cubic a b c)
  (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))

; 1.41

(define (double f)
  (lambda (x) (f (f x))))

(define (inc x) (+ x 1))
(((double (double double)) inc) 5) ;=> 21

; 1.42

(define (compose f g)
  (lambda (x) (f (g x))))

; 1.43

(define (repeated f n)
  (if (= n 0)
      identity
      (compose f (repeated f (- n 1)))))

; 1.44

(define (smooth f)
  (define dx 1)
  (lambda (x)
    (/
     (+
      (f (- x dx))
      (f x)
      (f (+ x dx)))
     3)))

(define (repeated-smooth f n)
  ((repeated smooth n) f))

; 1.45

(define (average-damp f)
  (define (average x y)
    (/ (+ x y) 2))
  (lambda (x) average x (f x)))

(define (fixed-point3 f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess cnt)
    (define increased-cnt (+ cnt 1))
    (display increased-cnt)
    (display ":")
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
           next
           (try next increased-cnt))))
  (try first-guess 0))

; Q1.46

(define (iterative-improve is-suitable improve)
  (define (itr-improve guess)
    (if (is-suitable guess)
        guess
        (itr-improve (improve guess))))
  itr-improve)

(define (sqrt x)
  ((iterative-improve
    (lambda (guess) (< (abs (- (square guess) x)) 0.00001))
    (lambda (guess) (average guess (/ x guess))))
   1.0))

(define (fixed-point4 f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? guess)
    (< (abs (- guess (f guess))) tolerance))
  ((iterative-improve close-enough? f) first-guess))

; Q2.1


    