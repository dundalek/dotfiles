# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022


#export EDITOR=/usr/bin/vim
export EDITOR=nvim
export SXHKD_SHELL=/bin/bash
# export TERMINAL=alacritty
export TERMINAL=gnome-terminal

# Auto-archive tasks automatically on completion
export TODOTXT_AUTO_ARCHIVE=1
# Prepend the current date to a task automatically when it's added.
export TODOTXT_DATE_ON_ADD=1
export TODOTXT_DEFAULT_ACTION=ls



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
