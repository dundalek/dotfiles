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

; https://github.com/sharkdp/bat
(defalias cat "bat --paging never")

; http://denilson.sa.nom.br/prettyping/
(defalias ping "prettyping --nolegend")

; https://dev.yorhel.nl/ncdu
(defalias du "ncdu --color dark -x --exclude .git --exclude node_modules")

(defabbr gaa "git add --all")
(defabbr gco "git checkout")
(defabbr gc "git clone")

(defabbr yt "youtube-dl --no-mtime --add-metadata")
(defabbr yta "youtube-dl --no-mtime --add-metadata --extract-audio")

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

(defn open-links
  "Opens links from input in firefox. Use like `cat links.txt | (open-links)`"
  [s]
  (->> s
    (re-seq #"https?://[^\s]+")
    (map #(sh firefox -private-window (identity %)))))

(defcmd man
  "Displays manual page but enhances it by showing also tldr page content first. To install the `unbuffer dependency` run `sudo apt install expect`. To install tldr client one can use `npm install -g tldr`."
  [& args]
  (if (= 1 (count args))
    (let [name (first args)]
      (sh bash -c (str "{ unbuffer tldr --theme ocean " name "; unbuffer /usr/bin/man -P cat " name "; } | less -RF")))
    (closh.zero.pipeline/wait-for-pipeline (shx "man" args))))

(defcmd github-user-email
  "Get an email for a given github user."
  [username]
  (->>
    (sh-str curl (str "https://api.github.com/users/" username "/events"))
    from-json
    (mapcat #(-> % :payload :commits))
    (map #(-> % :author))
    (frequencies)))

(defcmd git-delete-merged-branches
  "Deletes local git branches that are merged in remote master"
  []
  (sh git branch --merged origin/master | grep -v master | xargs --verbose --max-args=1 git branch -d))
