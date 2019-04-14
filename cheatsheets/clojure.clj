;; Clojure

;; Commas are always whitespace
;; () != nil in Clojure
;; Don't quote the empty list
;; In the repl, _ from irb is called *1

;; Number
42
;; String
"hello"
;; Character
\a

;; Boolean, only false and nil are falsy
(if true (println "Yep"))

;; Symbol
(def my-symbol 22/7)
(= 'hello (symbol "hello")) ;=> true

;; Keyword (more common than symbols) (why?)
:keyword
(= :hello (keyword "hello")) ;=> true

;; List
(function arg1 arg2 arg3)
(+ 1 2 3)
;; The usual suspects
(def words '("foo" "bar" "qux"))
(first words) ;=> "foo"
(rest words) ;=> ("bar" "qux")

;; You've also got next, which is subtly different from rest
(rest ()) ;=> ()
(next ()) ;=> nil

;; Vector, simply evaluates each item in order
(def letters [:a :b :c :d])
(nth letters 2) ;=> :c

;; Map
(def book {"title" "Oliver Twist" "author" "Dickens" "published" 1838})
(get book "title") ;=> "Oliver Twist"
(book "title") ;=> "Oliver Twist"

;; Can also treat keyword keys as function
(def another-book {:title "Oliver Twist" :author "Dickens" :published 1838})
(:author another-book) ;=> "Dickens"
(def updated-book (assoc another-book :rating 5)) ;=> a new map

;; Set
#{1 2 "three" :four 0x5}

;; The numbers 1 to 100
(range 1 101)

;; Simple assertions for framework-less testing
(assert (= 1 1))
(assert (not= 2 3))
;; Mathematical equality
(assert (== 1 1.0))

;; progn is called simply do
(do
  (println "Do")
  (println "Re")
  (println "Mi")
  50)

;; when is same as emacs
(when true
  (println "Do")
  (println "Re")
  (println "Mi"))

;; Functions
(defn double-it [x] (* 2 x))
;; Or as a lambda
(def double-it (fn [x] (* 2 x)))

;; http://funcall.blogspot.com/2009/03/not-lisp-again.html
(def dx 0.0001)

(defn deriv [f]
  (fn [x]
    (/ (- (f (+ x dx)) (f x))
       dx)))

(defn cube [x] (* x x x))

(def cube-deriv (deriv cube))
(defn three-x-squared [x] (* 3 (* x x)))

(cube-deriv 2) ;=> 12.000600010022566
(three-x-squared 2) ;=> 12

(cube-deriv 3) ;=> 27.00090001006572
(three-x-squared 3) ;=> 27

(cube-deriv 4) ;=> 48.00120000993502
(three-x-squared 4) ;=> 48
