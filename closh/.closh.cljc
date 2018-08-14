(require '[clojure.string :as str])
#?(:cljs
   (require '[cljs.nodejs]
            '[lumo.io :refer [slurp spit]]))

; workaround for load-file in lumo
#?(:cljs (refer-clojure :exclude '[load-file]))
#?(:cljs
   (defn load-file [f]
     (lumo.repl/execute-path f {})))

(defn closh-prompt []
  (str (sh-str powerline-shell --shell bare) " "))

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

(load-file (str (getenv "HOME") "/.closh_macros.clj"))
(load-file (str (getenv "HOME") "/.closh_functions.cljc"))
(load-file (str (getenv "HOME") "/.closh_private.cljc"))
(load-file (str (getenv "HOME") "/.closh_autojump.cljc"))
