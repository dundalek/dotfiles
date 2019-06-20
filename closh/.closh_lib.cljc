
;; == System

(defcmd open
  [path]
  (sh xdg-open (str path)))

(defcmd suspend
  "aka sleep, suspend to ram"
  []
  (sh systemctl suspend))

(defcmd hibernate
  "aka suspend to disk"
  []
  (sh systemctl hibernate))

(defcmd reboot
  "aka restart"
  []
  (sh systemctl reboot))

(defcmd shutdown
  "aka power off"
  []
  (sh systemctl poweroff))

;; == Session

(defcmd lock-screen
  []
  (sh xdg-screensaver lock))

(defcmd logout
  []
  (sh gnome-session-quit --no-prompt))

; (defcmd [] switch-user)

;; == Audio

(defn get-default-sink []
  "@DEFAULT_SINK@")

(defn get-default-volume-increment []
  6)

(defcmd volume
  ([value] (volume (get-default-sink) value))
  ([target value] (sh-ok pactl set-sink-volume (str target) (str value "%"))))

(defcmd volume-up
  ([] (volume-up (get-default-sink)))
  ([target] (volume-up target (get-default-volume-increment)))
  ([target value] (sh-ok pactl set-sink-volume (str target) (str "+" value "%"))))

(defcmd volume-down
  ([] (volume-down (get-default-sink)))
  ([target] (volume-down target (get-default-volume-increment)))
  ([target value] (sh-ok pactl set-sink-volume (str target) (str "-" value "%"))))

(defcmd mute
  ([] (mute (get-default-sink)))
  ([target] (sh-ok pactl set-sink-mute (str target) "toggle")))

(defcmd mute-on
  ([] (mute-on (get-default-sink)))
  ([target] (sh-ok pactl set-sink-mute (str target) "1")))

(defn mute-off
  ([] (mute-off (get-default-sink)))
  ([target] (sh-ok pactl set-sink-mute (str target) "0")))

(comment
  (volume-up)
  (volume-down)

  (volume 50)
  (volume 25)

  (mute)
  (mute-on)
  (mute-off))
