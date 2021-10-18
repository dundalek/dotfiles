# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
# case $- in
#     *i*) ;;
#       *) return;;
# esac

# append to the history file, don't overwrite it
shopt -s histappend

# http://blog.macromates.com/2008/working-with-history-in-bash/
# unlimited bash history
export HISTFILESIZE= HISTSIZE=
# A value of `ignorespace' means to not enter lines which begin with a space or tab into the history list. A value of `ignoredups' means to not enter lines which match the last entered line. A value of `ignoreboth' combines the two options.
export HISTCONTROL=ignoreboth
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

# https://wiki.archlinux.org/index.php/Color_Bash_Prompt

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White


if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#export EDITOR=/usr/bin/vim
export EDITOR=nvim
export SXHKD_SHELL=/bin/bash
# export TERMINAL=alacritty
export TERMINAL=gnome-terminal

# Linuxbrew
# test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)

# fnm
#export PATH="$HOME/.fnm:$PATH"
#eval "`fnm env --multi`"

# Javascript
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Rust language
# export PATH="$HOME/.cargo/bin:$PATH"

# Go lang
# export GOPATH="/home/me/bin/gocode"
# export GOROOT="/usr/local/go"
# export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

# Ruby - find the location with `gem environment`
# export PATH="$HOME/.gem/bin:$PATH"

# Python's pip3 installed packages
# export PATH="$HOME/.local/bin:$PATH"

# Lua
# export PATH="$HOME/.luarocks/bin:$PATH"

# OCaml
# eval $(opam env)

# Auto-archive tasks automatically on completion
export TODOTXT_AUTO_ARCHIVE=1
# Prepend the current date to a task automatically when it's added.
export TODOTXT_DATE_ON_ADD=1
export TODOTXT_DEFAULT_ACTION=ls
alias t='todo-txt'

# export PATH="$PATH:$HOME/usr/share/flutter/bin"

# export ANDROID_HOME="$HOME/usr/share/Android/Sdk"
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools


## Nix

if [ -e /home/me/.nix-profile/etc/profile.d/nix.sh ]; then . /home/me/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Fix for rofi under Nix, otherwise rofi fails to set locale and fails to start
# Install locales with: nix-env -i glibc-locales
export LOCALE_ARCHIVE="$HOME/.nix-profile/lib/locale/locale-archive"

# So that launcher picks up desktop files
export XDG_DATA_DIRS="$HOME/.local/share:$HOME/.nix-profile/share:$XDG_DATA_DIRS"

# Use a different path for globally installed npm packages, so that npm does not try to install them in /nix/store which will fail.
# Set the prefix with: npm config set prefix=$HOME/.npm-modules
export PATH="$HOME/.npm-modules/bin:$PATH"

# Workaround for running programs that use OpenGL
# https://github.com/guibou/nixGL
# https://github.com/NixOS/nixpkgs/issues/9415
#. nixGLIntel

# will likely break when updated
export LIBGL_DRIVERS_PATH=/nix/store/cv9iki6bhzpb00fp5dz48439yy1jx3sf-mesa-20.3.1-drivers/lib/dri:/nix/store/h3gav1nagfg6fxlbajvz0giximy2wyi1-mesa-20.3.1-drivers/lib/dri
export LD_LIBRARY_PATH=/nix/store/cv9iki6bhzpb00fp5dz48439yy1jx3sf-mesa-20.3.1-drivers/lib:/nix/store/h3gav1nagfg6fxlbajvz0giximy2wyi1-mesa-20.3.1-drivers/lib:/nix/store/2qzj8f96fqab2yakbjjycmk7kxgqfl68-mesa_glxindirect/lib:$LD_LIBRARY_PATH



[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin/scripts" ] ; then
    PATH="$HOME/bin/scripts:$PATH"
fi

if [ -d "$HOME/bin/private" ] ; then
    PATH="$HOME/bin/private:$PATH"
fi
