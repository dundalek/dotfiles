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
