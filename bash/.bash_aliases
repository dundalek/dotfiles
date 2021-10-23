#!/bin/bash

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias o="xdg-open"
alias pbcopy="xclip -selection c"
alias pbpaste="xclip -selection clipboard -o"
alias xclip="xclip -selection c"
alias cb="xclip -selection c"
alias st="sublime_text"

alias isom="mount -o loop -t iso9660"

alias slowget="wget --timeout=60 --tries=0 -c"

alias aunrar='for f in *.rar; do unrar x "$f"; done'
alias aunzip='for f in *.zip; do unzip "$f"; done'
alias amp3='for f in *.mp4 *.flv; do out=`echo "$f" | sed "s/\.mp4\|\.flv$/.m4a/"`; ffmpeg -i "$f" -vn -acodec copy "$out";done'

alias webs="python -m SimpleHTTPServer"
alias s="browser-sync start --server --directory --index=index.html --files='**/*'"
alias ss="browser-sync start --server --index=index.html --files='**/*'"

alias airplay='java -cp /home/joudy/dl/github/open-airplay/Java/build/airplay.jar:/home/joudy/dl/github/open-airplay/Java/lib/jmdns.jar com.jameslow.AirPlay'
alias airplay-work='airplay -h 10.1.10.18 -d'

alias bode='./node_modules/.bin/babel-node'
alias lumo="lumo -e \"(require '[lumo.io :refer [slurp spit]])\" -r"

alias jsh="node ~/bin/node_modules/shelljs/bin/shjs --coffee"

alias say='echo $@ | espeak -s 120 2>/dev/null'

alias t='todo-txt'

fotky() {
  p=$1
  [ -z "$p" ] && p=1280
  mkdir smaller 2>/dev/null
  for f in *.{JPG,JPEG,jpg,jpeg}; do convert "$f" -resize $p -strip "smaller/$f"; done
}

propstring () {
  echo -n 'Property '
  xprop WM_CLASS | sed 's/.*"\(.*\)", "\(.*\)".*/= "\1,\2" {/g'
  echo '}'
}

mpcmd () {
 echo -e "$*\\nclose" | nc localhost 6600 | sed -e '/^OK MPD/d;/^OK$/d'
}

trafprint() {
echo -en "  hodina    \t"; for a in `seq 1 23`; do printf "% 5d" "$a"; done; echo -e "\n"; awk -F- 'BEGIN{ORS=""; CONVFMT="% 4d";} { print $1 "\t"; for (a = 2; a < NF; a++) print " " ($a+1) / 1000000; print "\n"}' $1
}

title() {
    echo -e "\033]2;$*\007"
}

aextract() {
    outfile=$2
    if [ -n "$outfile"];then
      outfile=tmp.mp3
    fi
    mplayer -dumpaudio $1 -dumpfile $outfile
}

amerge() {
    outfile=$2
    if [ -n "$outfile"];then
      outfile=tmp.mp3
    fi
    mv $1 $1.old
    mencoder -audiofile $outfile -oac copy -ovc copy $1.old -o $1
}


## https://github.com/paulirish/dotfiles/blob/master/.functions

# Create a new directory and enter it
function md() {
    mkdir -p "$@" && cd "$@"
}


# find shorthand
function f() {
    find . -name "$1"
}

# get gzipped size
function gz() {
    echo "orig size    (bytes): "
    cat "$1" | wc -c
    echo "gzipped size (bytes): "
    gzip -c "$1" | wc -c
}

# Extract archives - use: extract <file>
# Credits to http://dotfiles.org/~pseup/.bashrc
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) rar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function ghclone() {
    cd ~/dl/git
    git clone git@github.com:$1.git
}


# Lookup shell on explainshell
function explainx() {
# Example url: http://explainshell.com/explain/tar?args=xzvf+archive.tar.gz
    URL="http://explainshell.com/explain"
    FIRST=0
    for i; do
        if [ $FIRST -eq 0 ]; then
            URL="${URL}/$i?args="
            FIRST=1
        elif [ $FIRST -eq 1 ]; then
            URL="${URL}${i}+"
        fi
        echo "arg: $i"
    done
    # Remove last +
    URL="${URL%?}"
    #echo "URL is $URL"
    xdg-open "$URL"
}

function explain() {
  curl -s $(echo "http://explainshell.com/explain/$1?args=${@:2}" | sed -e 's/ /+/g') |
  sed -n '/<pre/,/<\/pre>/p' | sed -s 's/<[^>]*>//g' | sed -e 's/^ *//g;s/ *$//g' | grep '.' | cat
}

# http://lifehacker.com/5592047/turn-your-command-line-into-a-fast-and-simple-note+taking-tool
NOTES_DIR=$HOME/Dropbox/notes
nn () {
    [ ! -d $NOTES_DIR ] && mkdir -p $NOTES_DIR
    ${EDITOR:-vi} $NOTES_DIR/"$*"
}
nls() {
    ls -c ~/notes/ | grep "$*"
}

randpw() {
  pw=`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c20`
  echo "$pw" | xclip -selection c
  echo "$pw" copied to clipboard
}
