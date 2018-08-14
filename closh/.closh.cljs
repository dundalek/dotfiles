
(require '[cljs.nodejs]
         '[clojure.string :as str]
         '[lumo.io :refer [slurp spit]])

; workaround for load-file in lumo
(refer-clojure :exclude '[load-file])
(defn load-file [f]
  (lumo.repl/execute-path f {}))

(defn closh-prompt []
  (str (sh-str powerline-shell --shell bare) " "))

; (defn closh-title []
;   (str "closh " (js/Date.now) " " (js/process.cwd)))



(source-shell "export NVM_DIR=\"$HOME/.nvm\"; [ -s \"$NVM_DIR/nvm.sh\" ] && . \"$NVM_DIR/nvm.sh\"")

(defn args->str [args]
  (->> args
    (map #(str "'" (clojure.string/replace % #"'" "'\"'\"'") "'"))
    (clojure.string/join " ")))

(defcmd nvm [& args]
  (print (source-shell (str ". \"$NVM_DIR/nvm.sh\"; nvm " (args->str args)))))



(source-shell "export PATH=\"$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH\"")

; Rust language
(setenv "PATH" (str (getenv "HOME") "/.cargo/bin" ":" (getenv "PATH")))

(defcmd history []
  (sh sqlite3 (str (getenv "HOME") "/.closh/closh.sqlite") "SELECT command FROM history ORDER BY id ASC" | cat))

(defalias ls "ls --color=auto")

(defalias gk "gitkraken --path")

(defalias s "browser-sync start --server --directory --index=index.html \"--files=**/*\"")
(defalias ss "browser-sync start --server --index=index.html \"--files='**/*\"")

(setenv "TODOTXT_AUTO_ARCHIVE" "1")
(setenv "TODOTXT_DATE_ON_ADD" "1")
(setenv "TODOTXT_DEFAULT_ACTION" "ls")
(defalias t "todo-txt")

(defalias pbcopy "xclip -selection c")
(defalias pbpaste "xclip -selection clipboard -o")


(defabbr gaa "git add --all")
(defabbr gco "git checkout")
(defabbr gc "git clone")

(defcmd gz
  "Compare original and gzipped size of a file"
  [f]
  (println "orig size    (bytes): ")
  (sh cat (str f) | wc -c)
  (println "gzipped size (bytes): ")
  (sh gzip -c  (str f)  | wc -c))

(defcmd ppr
  "Fetches and checks out a branch for a given PR number. Useful to quickly test contributions."
  [n]
  (sh git fetch origin (str "pull/" n "/head:PR-" n) && git checkout (str "PR-" n)))

(defcmd cdx
  "Quickly jump to a selected folder using ranger."
  []
  (let [f (str (getenv "HOME") "/.rangerdir")]
    (sh ranger --choosedir (str f) && cd (slurp f))))

(load-file (str (getenv "HOME") "/.closh_autojump.cljs"))
