
# do not show the greeting message
set fish_greeting

export NVM_DIR="/home/me/.nvm"
[ -s "$NVM_DIR/nvm.sh" ]; and not set -q NVM_BIN; and bass source "$NVM_DIR/nvm.sh"  # This loads nvm

### Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"

set -gx GOPATH "/home/me/bin/gocode"
set -gx PATH $GOPATH/bin $PATH

export ANDROID_HOME=$HOME/bin/bin/Android/Sdk
export ANDROID_NDK=$ANDROID_HOME/ndk-bundle
set PATH $PATH $ANDROID_HOME/platform-tools $ANDROID_HOME/tools $ANDROID_HOME/ndk-bundle

alias s "browser-sync start --server --directory --index=index.html --files='**/*'"
alias ss "browser-sync start --server --index=index.html --files='**/*'"

export TODOTXT_AUTO_ARCHIVE=1
export TODOTXT_DATE_ON_ADD=1
export TODOTXT_DEFAULT_ACTION=ls
alias t todo-txt

alias pbcopy "xclip -selection c"
alias pbpaste "xclip -selection clipboard -o"

#alias lumo "lumo -e \"(require '[lumo.io :refer [slurp spit]])\" -r"

