(ns main  (:require [clojure.string :as str]))

(defn smaller? [x]
  (< x 0))

(defn reset-timer [e]
  (if (smaller? e) 6 e))

(defn add-children [count lst]
  (loop [c count, l lst]
    (if (zero? c)
      l
      (recur (dec c) (conj l 8)))))

(defn recreate [lst]
  (add-children (count (filterv smaller? lst)) lst))

(defn simulate [days lst]
  (loop [d days, l lst]
    (if (zero? d)
      l
      (->> l
           (map dec)
           (recreate)
           (map reset-timer)
           (recur (dec d))))))

(defn read-file-into-list [filename]
  (as-> (slurp filename) x
    (str/split x #",")  ; To list of String.
    (map read-string x) ; To Integers.
    ))

(def lst (read-file-into-list "input.txt"))
(println (count (simulate 80 lst)))
