
# do not show the greeting message
set fish_greeting

alias s "browser-sync start --server --directory --index=index.html --files='**/*'"
alias ss "browser-sync start --server --index=index.html --files='**/*'"

alias ls "ls --color=auto"
alias ll "ls -l --color=auto"
alias dd "dd status=progress"

alias s "browser-sync start --server --directory --index=index.html \"--files=**/*\""
alias ss "browser-sync start --server --index=index.html \"--files='**/*\""

alias o "xdg-open"

alias pbcopy "xclip -selection c"
alias pbpaste "xclip -selection clipboard -o"

# https://github.com/sharkdp/bat
#alias cat "bat --paging never"

# http://denilson.sa.nom.br/prettyping/
alias ping "prettyping --nolegend"

abbr -a p1 "ping 1.1.1.1"
abbr -a p8 "ping 8.8.8.8"

# https://dev.yorhel.nl/ncdu
# alias du "ncdu --color dark -x --exclude .git --exclude node_modules"

abbr -a jp "j pitch"
abbr -a jc "j closh"
abbr -a jl "j liz"

abbr -a tp "tmux-pitch"

abbr -a cm "clj -m"
abbr -a jj "java -jar"
abbr -a sm "smerge"

abbr -a .. "cd .."
abbr -a ... "cd ../.."

abbr -a gd "git diff"
abbr -a gds "git diff --cached"
abbr -a gaa "git add --all"
abbr -a gap "git add -p"
abbr -a gcp "git checkout -p" # reset chunks from working are
abbr -a gr "git reset"
abbr -a grp "git reset HEAD -p" # unstage chunks
abbr -a gs "git status"
abbr -a gc "git checkout"
abbr -a gcm "git checkout master"
# abbr -a gcl "git clone"
abbr -a gfo "git fetch origin"
abbr -a gp "git pull"
abbr -a gpp "git push"
alias git-delete-merged-branches "git branch --merged origin/master | grep -v master | xargs --verbose --max-args=1 git branch -d"

abbr -a lg "lazygit"

abbr -a dl "cd ~/Downloads"

abbr -a nixs "nix-shell"
abbr -a nixsh "nix-shell --command closh-zero-sci"
abbr -a nixp "nix-shell -p"
abbr -a nixi "nix-env -i"
abbr -a nixe "nix-env -e"
abbr -a nixq "nix-env -q"
abbr -a nixd "nix develop"

function nixr
  set -l program $argv[1]
  command nix-shell -p $program --run $program
end

alias unf "env NIXPKGS_ALLOW_UNFREE=1"

#(defcmd nixr [program]
#  (sh nix-shell -p (str program) --run (str program))

abbr -a yt "youtube-dl --no-mtime --add-metadata"
# m4a format is used so that thumbnail can be included
# Needs sudo apt-get install atomicparsley
abbr -a yta "youtube-dl -f m4a --no-mtime --add-metadata --embed-thumbnail --extract-audio"


