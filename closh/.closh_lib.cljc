
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
