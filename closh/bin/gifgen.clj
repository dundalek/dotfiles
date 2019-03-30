#!/usr/bin/env closh-zero.jar

(require '[clojure.tools.cli :refer [parse-opts]])

(def cli-options
  [["-o" "--output OUTPUT" "Output file"
    :default-desc "[input.gif]"]
   ["-f" "--fps FPS" "Frames per second"
    :default "10"]
   ["-s" "--static" "Optimize for static background"
    :id :mode
    :default {:stats-mode "full" :dither "sierra2_4a"}
    :update-fn (constantly {:stats-mode "diff" :dither "none"})]
   ["-v" "--verbose" "Display verbose output from ffmpeg"
    :id :verbosity
    :default "warning"
    :update-fn (constantly "info")]
   ["-h" "--help" "Show help"]])

;; Get help/usage message, uses options summary from cli-options
(defn help [options-summary]
  (->>
   ["gifgen 1.1.2-closh"
    ""
    "Usage: gifgen [options] [input]"
    ""
    "Options:"
    options-summary
    ""
    "Examples:"
    "  $ gifgen video.mp4"
    "  $ gifgen -o demo.gif SCM_1457.mp4"
    "  $ gifgen -sf 15 screencap.mov"]
   (str/join \newline)))

;; Encode GIF
(defn encode-gif [input options]
  (let [{:keys [fps verbosity output] {:keys [stats-mode dither]} :mode} options
        ;; in Java 9+ it can be: pid (-> (ProcessHandle.) .current .pid)
        pid (.getName (java.lang.management.ManagementFactory/getRuntimeMXBean))
        palette (str "/tmp/gif-palette-" pid ".png")
        output (or output (str/replace input #"^(?:.*/)?(.+)\..*$" "$1.gif"))]
    (sh
       echo "Generating palette..." \;
       ffmpeg -v (str verbosity) -i (str input) -vf (str "fps=" fps ",palettegen=stats_mode=" stats-mode) -y (str palette) \;
       (when (= verbosity "info") (println)) \;
       echo "Encoding GIF..." \;
       ffmpeg -v (str verbosity) -i (str input) -i (str palette) -lavfi (str "fps=" fps " [x]; [x][1:v] paletteuse=dither=" dither) -y (str output) \;
       echo "Done!")))

(let [{:keys [options arguments summary]} (parse-opts *args* cli-options)]
  ;; Show help and exit if we have no input
  (when (or (empty? arguments) (:help options))
    (println (help summary))
    (System/exit 0))

  ;; Check for ffmpeg before encoding
  (when (= "" (sh-str which ffmpeg))
    (println "Error: gifgen requires ffmpeg to be installed")
    (System/exit 1))

  (encode-gif (first arguments) options))
