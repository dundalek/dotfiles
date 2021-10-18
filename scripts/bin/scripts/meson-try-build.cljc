#!/usr/bin/env closh-zero.jar

(defn try-build []
  (let [out (sh-str meson build)]
    (second (re-find #"ERROR:  Dependency \"([^\"]+)\" not found, tried pkgconfig and cmake" out))))

(defn find-candidates [pkg]
  (println "=== finding candidates " pkg)
  (->> (sh-str apt-cache search (str pkg))
       (str/split-lines)
       (map #(first (str/split % #"\s+")))
       (filter #(re-find #"-dev$" %))))

(defn -main
  "Tries to build using meson and then searches for missing dev dependencies using apt."
  []
  (loop []
    (let [missing (try-build)]
      (when-not (str/blank? missing)
        (println "=== Missing:" missing)
        (let [candidates (find-candidates [missing])
              candidates (if (seq candidates)
                           candidates
                           (find-candidates (str/replace missing #"-[\d.+]+$" "")))]
          (when (seq candidates)
            (println "=== Found:" candidates)
            (doseq [p candidates]
              (println "Installing:" p)
              (sh sudo apt install (str p)))
            (recur)))))))
