(defn add-dependencies
  "A helper function to lazily load dependencies using Pomegranate."
  [& args]
  (when-not (find-ns 'cemerick.pomegranate)
    (require '[cemerick.pomegranate]))
  (apply (resolve 'cemerick.pomegranate/add-dependencies)
    (concat args
      [:repositories (merge @(resolve 'cemerick.pomegranate.aether/maven-central) {"clojars" "https://clojars.org/repo"})])))


; EDN
; ====================

(defcmd from-edn [s]
  (clojure.edn/read-string s))

(defcmd to-edn [& more]
  (apply prn-str more))


; JSON
; ====================

(defcmd from-json [& args]
  (if (= (count args) 1)
    ; Keywordize keys by default
    (clojure.data.json/read-str (first args) :key-fn keyword)
    (apply clojure.data.json/read-str args)))

(defcmd to-json [& args]
  (apply clojure.data.json/write-str args))


; CSV
; ====================

; Maybe integrate csv-data->maps as an option, e.g. (from-csv input :maps true)
(defcmd from-csv [s]
  (when-not (find-ns 'clojure.data.csv)
    (add-dependencies :coordinates '[[org.clojure/data.csv "0.1.4"]])
    (require '[clojure.data.csv]))
  ((resolve 'clojure.data.csv/read-csv) s))

(defcmd to-csv [x]
  (when-not (find-ns 'clojure.data.csv)
    (add-dependencies :coordinates '[[org.clojure/data.csv "0.1.4"]])
    (require '[clojure.data.csv]))
  (let [writer (java.io.StringWriter.)]
    ((resolve 'clojure.data.csv/write-csv) writer x)
    (str writer)))

; From https://github.com/clojure/data.csv/blob/master/README.md
(defcmd csv-data->maps [csv-data]
  (map zipmap
       (->> (first csv-data) ;; First row is the header
            (map keyword) ;; Drop if you want string keys instead
            repeat)
    (rest csv-data)))


; XML
; ====================

(defcmd from-xml [& args]
  (when-not (find-ns 'clojure.data.xml)
    (add-dependencies :coordinates '[[org.clojure/data.xml "0.0.8"]])
    (require '[clojure.data.xml]))
  (apply (resolve 'clojure.data.xml/parse-str) args))

(defcmd to-xml [& args]
  (when-not (find-ns 'clojure.data.xml)
    (add-dependencies :coordinates '[[org.clojure/data.xml "0.0.8"]])
    (require '[clojure.data.xml]))
  (apply (resolve 'clojure.data.xml/emit-str) args))


; html->hiccup
; ====================

(defcmd html->hiccup [s]
  (when-not (find-ns 'hiccup-bridge.core)
    (add-dependencies :coordinates '[[hiccup-bridge "1.0.1"]])
    (require '[hiccup-bridge.core]))
  ((resolve 'hiccup-bridge.core/html->hiccup) s))

; (defcmd html->hiccup [s]
;   (when-not (find-ns 'hickory.core)
;     (add-dependencies :coordinates '[[hickory "0.7.1"]])
;     (require '[hickory.core]))
;   (-> s
;     ((resolve 'hickory.core/parse))
;     ((resolve 'hickory.core/as-hiccup))))

(defcmd hiccup->html [s]
  (when-not (find-ns 'hickory.render)
    (add-dependencies :coordinates '[[hickory "0.7.1"]])
    (require '[hickory.render]))
  (let [forms (if (string? s) (from-edn s) s)
        forms (if (keyword? (first forms)) [forms] forms)]
    ((resolve 'hickory.render/hiccup-to-html) forms)))

; Misc
; ====================

(defcmd to-slug [s]
  (when-not (find-ns 'slugger.core)
    (add-dependencies :coordinates '[[slugger "1.0.1"]])
    (require '[slugger.core]))
  ((resolve 'slugger.core/->slug) s))

(defn string->stream [s]
  (java.io.ByteArrayInputStream. (.getBytes s java.nio.charset.StandardCharsets/UTF_8)))

(defcmd from-transit [s]
  (when-not (find-ns 'cognitect.transit)
    (add-dependencies :coordinates '[[com.cognitect/transit-clj "0.8.313"]])
    (require '[cognitect.transit]))
  (let [reader (resolve 'cognitect.transit/reader)
        read (resolve 'cognitect.transite/read)]
    (read (reader (string->stream s) :json {:handlers {"u" #(java.util.UUID/fromString %)}}))))

; (defcmd to-transit [s]
;   (when-not (find-ns 'cognitect.transit)
;     (add-dependencies :coordinates '[[com.cognitect/transit-clj "0.8.313"]])
;     (require '[cognitect.transit]))
;   (let [writer (resolve 'cognitect.transit/writer)
;         write (resolve 'cognitect.transite/write)]
;     (read (reader (string->stream s) :json))))
