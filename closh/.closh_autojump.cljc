(require #?(:cljs 'path :clj 'clojure.java.io))

(setenv "AUTOJUMP_SOURCED" 1)

(defn- dirname [filename]
  #?(:cljs (path/dirname filename)
     :clj (.getParent (clojure.java.io/file filename))))

(def ^:private is-mac
  #?(:cljs (= js/process.platform "darwin")
     :clj (pos? (.indexOf (.toLowerCase (System/getProperty "os.name")) "mac"))))

(when (sh-ok test -d (str (getenv "HOME") "/.autojump"))
  (setenv "PATH" (str (getenv "HOME") "/.autojump/bin" ":" (getenv "PATH"))))

(def AUTOJUMP_ERROR_PATH
  (cond
    is-mac
    (str (getenv "HOME") "/Library/autojump/errors.log")

    (sh-ok test -d (getenv "XDG_DATA_HOME"))
    (str (getenv "XDG_DATA_HOME") "/autojump/errors.log")

    :else (str (getenv "HOME") "/.local/share/autojump/errors.log")))

(if-not (sh-ok test -d (dirname AUTOJUMP_ERROR_PATH))
  (sh mkdir -p (dirname AUTOJUMP_ERROR_PATH)))

(def original-closh-prompt closh-prompt)

(defn closh-prompt []
  (sh autojump --add (getenv "PWD") > "/dev/null" 2 >> (str AUTOJUMP_ERROR_PATH))
  (original-closh-prompt))

(defn autojump [& args]
  (-> (shx "autojump" args)
      (closh.zero.pipeline/process-output)
      (clojure.string/trim)))

(defn autojump-cd [& args]
  (if (= (ffirst args) "-")
    (-> (shx "autojump" args)
        (closh.zero.pipeline/wait-for-pipeline))
    (let [output (apply autojump args)]
      (if (= output ".")
        (apply cd args)
        (do
          (println output)
          (cd output))))))

(defn autojump-open [& args]
  (let [output (apply autojump args)
        cmd (if is-mac "open" "xdg-open")]
    (shx cmd [output])))

(defn- autojump-wrap-child [f]
  (fn [& args]
    (if (= (ffirst args) "-")
      (apply f args)
      (apply f (conj args (getenv "PWD"))))))

(defcmd j autojump-cd)
(defcmd jc (autojump-wrap-child autojump-cd))
(defcmd jo autojump-open)
(defcmd jco (autojump-wrap-child autojump-open))

; e.g. `atom (j 'project-name)`
; It would be better to do it as macro (so that quoting is not necessary), but I am not sure how to load user defined macros in cljs.
(def j autojump)
