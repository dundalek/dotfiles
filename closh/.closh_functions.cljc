(defcmd history []
  (sh sqlite3 (str (getenv "HOME") "/.closh/closh.sqlite") "SELECT command FROM history ORDER BY id ASC" | cat))

(defalias ls "ls --color=auto")
(defalias ll "ls -l --color=auto")
(defalias dd "dd status=progress")

(defalias gk "gitkraken --path")
; (defalias code "codium")
(defalias nvm "fnm")

(defalias s "browser-sync start --server --directory --index=index.html \"--files=**/*\"")
(defalias ss "browser-sync start --server --index=index.html \"--files='**/*\"")

(setenv "TODOTXT_AUTO_ARCHIVE" "1")
(setenv "TODOTXT_DATE_ON_ADD" "1")
(setenv "TODOTXT_DEFAULT_ACTION" "ls")
(defalias t "todo-txt")

; (defcmd pbcopy []
;   (sh xclip -selection c))

(defalias o "xdg-open")

(defcmd pbpaste []
  (sh-str xclip -selection c -o))

(defalias pbcopy "xclip -selection c")
(defalias pbpaste "xclip -selection clipboard -o")

; https://github.com/sharkdp/bat
;(defalias cat "bat --paging never")

; http://denilson.sa.nom.br/prettyping/
(defalias ping "prettyping --nolegend")

(defabbr p1 "ping 1.1.1.1")
(defabbr p8 "ping 8.8.8.8")

; https://dev.yorhel.nl/ncdu
;; (defalias du "ncdu --color dark -x --exclude .git --exclude node_modules")

(defabbr jp "j pitch")
(defabbr jc "j closh")
(defabbr jl "j liz")

(defabbr tp "tmux-pitch")

(defabbr cm "clj -m")
(defabbr jj "java -jar")
(defabbr sm "smerge")

(defabbr .. "cd ..")
(defabbr ... "cd ../..")

(defabbr gd "git diff")
(defabbr gds "git diff --cached")
(defabbr gaa "git add --all")
(defabbr gap "git add -p")
(defabbr gcp "git checkout -p") ;; reset chunks from working are
(defabbr gr "git reset")
(defabbr grp "git reset HEAD -p") ;; unstage chunks
(defabbr gs "git status")
(defabbr gc "git checkout")
(defabbr gcm "git checkout master")
; (defabbr gcl "git clone")
(defabbr gfo "git fetch origin")
(defabbr gp "git pull")
(defabbr gpp "git push")

(defabbr lg "lazygit")

(defabbr dl "cd ~/Downloads")

(defabbr nixs "nix-shell")
(defabbr nixsh "nix-shell --command closh-zero-sci")
(defabbr nixp "nix-shell -p")
(defabbr nixi "nix-env -i")
(defabbr nixe "nix-env -e")
(defabbr nixq "nix-env -q")
(defabbr nixd "nix develop")

(defalias unf "env NIXPKGS_ALLOW_UNFREE=1")

(defcmd nixr [program]
  (sh nix-shell -p (str program) --run (str program)))

(defabbr yt "youtube-dl --no-mtime --add-metadata")
;; m4a format is used so that thumbnail can be included
;; Needs sudo apt-get install atomicparsley
(defabbr yta "youtube-dl -f m4a --no-mtime --add-metadata --embed-thumbnail --extract-audio")

(defalias update-youtube-dl "curl -L https://yt-dl.org/downloads/latest/youtube-dl -o (sh-str which youtube-dl)")

#?(:clj
   (defcmd random-uuid []
     (.toString (java.util.UUID/randomUUID))))

(defcmd gz
  "Compare original and gzipped size of a file"
  [f]
  (println "orig size    (bytes): ")
  (sh cat (str f) | wc -c)
  (println "gzipped size (bytes): ")
  (sh gzip -c  (str f)  | wc -c))

(defcmd amp3
  "Extract audio tracks from video files in a current folder"
  []
  (doseq [f (expand "*.{mp4,flv}")]
    (sh ffmpeg -i (str f) -vn -acodec copy (str/replace f #"\.mp4|\.flv$" ".m4a"))))

(defcmd ppr
  "Fetches and checks out a branch for a given PR number. Useful to quickly test contributions."
  [n]
  (sh git fetch origin (str "pull/" n "/head:PR-" n) && git checkout (str "PR-" n)))

(defcmd cdx
  "Quickly jump to a selected folder using ranger."
  []
  (let [f (str (getenv "HOME") "/.rangerdir")]
    (sh ranger --choosedir (str f) && cd (slurp f))))

(defcmd extract-links
  "Extract HTTP links from a string"
  [s]
  (re-seq #"https?://[^\s]+" s))

(defcmd ff-open
  "Open URL in a new private Firefox tab"
  [s]
  (sh firefox -private-window (str s)))

(defcmd open-links
  "Opens links from input in firefox. Use like `cat links.txt | (open-links)`"
  [s]
  (->> s
       (extract-links)
       (map ff-open)))

(defcmd man
  "Displays manual page but enhances it by showing also tldr page content first. To install the `unbuffer dependency` run `sudo apt install expect`. To install tldr client one can use `npm install -g tldr`."
  [& args]
  (if (= 1 (count args))
    (let [name (first args)]
      (sh bash -c (str "{ unbuffer tldr " name "; unbuffer /usr/bin/man -P cat " name " || unbuffer " name " --help; } | less -RF")))
    (closh.zero.pipeline/wait-for-pipeline (shx "man" args))))

#_(when-not (getenv "__CLOSH_USE_SCI_EVAL__")
    (defcmd github-user-email
      "Get an email for a given github user."
      [username]
      (->>
       (sh-str curl (str "https://api.github.com/users/" username "/events"))
       from-json
       (mapcat #(-> % :payload :commits))
       (map #(-> % :author))
       (frequencies))))

(defcmd git-delete-merged-branches
  "Deletes local git branches that are merged in remote master"
  []
  (sh git branch --merged origin/master | grep -v master | xargs --verbose --max-args=1 git branch -d))

(defn resolve-repo-url [repo]
  (cond
    (re-matches #"^[^/]+/[^/]+$" repo) (str "https://github.com/" repo ".git")
    (not (re-find #"\.git$" repo)) (str repo ".git")
    :else repo))

(defcmd ghclone
  "Clones a git repo. Argument can be:
  - `username/repo` in which case it will cloned from GitHub
  - copied from browser location bar like `https://github.com/username/repo`
  - or any full git url like `git@github:..` or `git://...` etc."
  [repo]
  (let [dir (str (getenv "HOME") "/Downloads/git")]
    (when-not (str/starts-with? (getenv "PWD") dir)
      (sh cd (str dir)))
    (sh git clone (resolve-repo-url repo))))

(defcmd ghcloc
  "Runs cloc command to count lines of code on a remote git repo."
  [repo]
  (let [tmp-dir (sh-str mktemp -d)]
    (sh git clone --depth 1 (resolve-repo-url repo) (str tmp-dir) \;
        cloc (str tmp-dir))))

#?(:clj
   (defcmd wait-for-enter []
     (print "Press Enter to continue: ")
     (flush)
     (read-line)
     (println)))

; #?(:clj
;    (import '(java.time LocalDateTime format.DateTimeFormatter)))
;
; (defn now []
;   #?(:clj (LocalDateTime/now)
;      :cljs (js/Date.)))
;
; (defn format-today
;   ([] (format-today  (now)))
;   ([d]
;    #?(:clj (.format d (DateTimeFormatter/ofPattern "EE d.M."))
;       :cljs (let [dayname (.toLocaleDateString d "en-US" #js { "weekday" "short"})]
;               (str dayname " " (.getDate d)  "." (inc (.getMonth d)) ".")))))
;
; (defn format-year-month
;   ([] (format-year-month (now)))
;   ([d]
;    #?(:clj (.format d (DateTimeFormatter/ofPattern "yyMM"))
;       :cljs (str
;              (-> d (.getFullYear) (mod 100) (str) (.padStart 2 "0"))
;              (-> d (.getMonth) (inc) (str) (.padStart 2 "0"))))))
;
; (defn open-journal [filename]
;   (println "Opening" filename)
;   (sh vim -c (str "1 s/^/" (format-today) "\r\r\r\r/") "+3" -c startinsert (str filename)))
;
; (defcmd jn []
;   (open-journal
;    (str (getenv "HOME") "/Dropbox/myfiles/denik/denik" (format-year-month) ".txt")))
;
; (defcmd djn []
;   (open-journal (str (getenv "HOME") "/Dropbox/myfiles/denik/ADenik-dev.md")))
;
; (defcmd wjn []
;   (open-journal
;     (str (getenv "HOME") "/Dropbox/myfiles/zpitch/pitch-dev-log-" (format-year-month) ".md")))
