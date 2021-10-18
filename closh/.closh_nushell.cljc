(defn mktempfifo []
  (let [path (str (sh-str mktemp -d) "/fifo")]
    (sh mkfifo -m 600 (str path))
    path))

(defn nucommand [cmd]
  (let [fifo-path (mktempfifo)]
    (.start
      (java.lang.Thread. #(sh echo (str cmd " | to-json | save " fifo-path " --raw") | nu > "/dev/null")))
    (->
      (slurp fifo-path)
      (clojure.data.json/read-str :key-fn keyword))))

(defcmd nups []
  (nucommand "ps"))

(defcmd nuls []
  (nucommand "ls"))

(defcmd nusys []
  (nucommand "sys"))

(defcmd nuopen [f]
  (nucommand (str "open " f)))

(defcmd nuview [value]
  (let [fifo-path (mktempfifo)]
    (.start
      (java.lang.Thread. #(->> (clojure.data.json/write-str value)
                           (spit fifo-path))))
    (sh echo (str "cat " fifo-path " | from-json | autoview") | nu)))

(comment
  (->>
    (nups)
    (filter #(even? (:pid %)))
    (map #(select-keys % [:pid :name]))
    (nuview))

  (->>
    (nusys)
    :cpu
    (nuview))

  (->> (nuopen "../websites/dundalek.com/netlify.toml")
       (nuview)))
