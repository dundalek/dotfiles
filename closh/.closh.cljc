;;-*- clojure -*-

; workaround for load-file in lumo
#?(:cljs (refer-clojure :exclude '[load-file]))
#?(:cljs
   (defn load-file [f]
     (lumo.repl/execute-path f {})))
; #?(:cljs (require '[lumo.repl :refer [load-file]]))

(require '[clojure.string :as str])
#?(:cljs
   (require '[cljs.nodejs]
            '[lumo.io :refer [slurp spit]]))

; (defn closh-title []
;   "hello")

; (defn closh-prompt []
;   (str "\u001b[01;32m" (getenv "USER") "\u001b[0m:\u001b[01;34m\u2026/" (last (clojure.string/split (getenv "PWD") #"/")) "\u001b[0m$ "))

(defn closh-prompt []
  ; (source-shell "bash" "eval \"$(direnv export bash)\"")
  ;(str (sh-str powerline-shell --shell bare) #?(:cljs " js> " :clj " ")))
  (str (sh-str powerline-go -shell bare -mode compatible -modules "time,nix-shell,venv,ssh,cwd,perms,git,hg,jobs,exit,root" -git-disable-stats stashed)
       #_(when (getenv "IN_NIX_SHELL") "[nix]")
       " "))

;; Putting ENV variable setting in ~/.profile
;; There will always be some legacy setting, so we at least source external shell only once
(source-shell ". ~/.bashrc")

; (defn args->str [args]
;   (->> args
;     (map #(str "'" (clojure.string/replace % #"'" "'\"'\"'") "'"))
;     (clojure.string/join " ")))
;
; (defcmd nvm [& args]
;   (print (source-shell (str ". \"$NVM_DIR/nvm.sh\"; nvm " (args->str args)))))

; #?(:cljs
;     (defcmd from-json [& args]
;       (-> (js/JSON.parse (first args))
;           (js->clj :keywordize-keys true))))
;
; #?(:cljs
;     (defcmd to-json [& args]
;       (-> (clj->js (first args))
;           (js/JSON.stringify))))

; (when-not (getenv "__CLOSH_USE_SCI_EVAL__")
;   #?(:clj (load-file (str (getenv "HOME") "/.closh_data_utils.cljc"))))
(load-file (str (getenv "HOME") "/.closh_macros.clj"))
(load-file (str (getenv "HOME") "/.closh_functions.cljc"))
(load-file (str (getenv "HOME") "/.closh_private.cljc"))
(load-file (str (getenv "HOME") "/.closh_autojump.cljc"))
; (when-not (getenv "__CLOSH_USE_SCI_EVAL__")
;   (load-file (str (getenv "HOME") "/.closh_nushell.cljc")))

(comment
  #?(:clj
     (do
       (require '[cemerick.pomegranate])
       (cemerick.pomegranate/add-dependencies
         :coordinates '[[funcool/datoteka "1.1.0"]]
         :repositories (merge cemerick.pomegranate.aether/maven-central
                              {"clojars" "https://clojars.org/repo"}))
       (require '[datoteka.core :as f]))))

; (defcmd rebl [x]
;   ; (when-not (find-ns 'cemerick.pomegranate)
;   ;   (require '[cemerick.pomegranate]))
;   ; ((resolve 'cemerick.pomegranate/add-dependencies)
;   ;  :coordinates '[[org.clojure/core.async "0.4.490"]
;   ;                 [org.openjfx/javafx-fxml "11.0.1"]
;   ;                 [org.openjfx/javafx-controls "11.0.1"]
;   ;                 [org.openjfx/javafx-swing    "11.0.1"]
;   ;                 [org.openjfx/javafx-base     "11.0.1"]
;   ;                 [org.openjfx/javafx-web      "11.0.1"]])
;   ; ((resolve 'cemerick.pomegranate/add-classpath)
;   ;  (clojure.java.io/file "/home/me/bin/vendor/REBL-0.9.220.jar"))
;   (when-not (find-ns 'cognitect.rebl)
;     (require '[cognitect.rebl]))
;   ((resolve 'cognitect.rebl/ui))
;   ((resolve 'cognitect.rebl/inspect) x 1))

; (require '[cognitect.rebl])
;
; (defcmd rebl-start []
;   (cognitect.rebl/ui))
;
; (defcmd rebl [x]
;   (cognitect.rebl/inspect x))
;
; (defn extension [s] (re-find #"[^.]*$" s))
;
; (defn from-edn [s] (clojure.edn/read-string s))
;
; (defcmd from-edn [s] (clojure.edn/read-string s))
