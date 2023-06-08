#!/usr/bin/env bb
;; -*- clojure -*-

(import '(java.time DayOfWeek LocalDate))

(defn working-day? [dt]
  (let [d (.getDayOfWeek dt)]
    (and (not= d DayOfWeek/SATURDAY)
         (not= d DayOfWeek/SUNDAY))))

(defn day-seq [dt]
  (lazy-seq (cons dt (day-seq (.plusDays dt 1)))))

(def manday-rate 370)

(let [dt (LocalDate/now)
      ; dt (LocalDate/of (.getYear dt) 1 1)
      current-month (.getMonthValue dt)
      groups (->> (day-seq (.withDayOfMonth dt 1))
                  (take-while #(= (.getMonthValue %) current-month))
                  (map (fn [dt] {:date (.getDayOfMonth dt)
                                 :working? (working-day? dt)}))
                  (partition-by :working?)
                  (filter #(-> % first :working?)))]
  (doseq [days groups]
    (println (format "%d\t%d.%d. - %d.%d."
                     (count days)
                     (-> days first :date) current-month
                     (-> days last :date) current-month))))

