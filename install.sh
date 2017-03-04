#!/bin/bash

# Base Script File (install.sh)
# Created: Mon Jul  1 15:03:41 2013
# Version: 1.0
# Author: François-Xavier Thomas <fx.thomas@gmail.com>
#
# This Bash script was developped by François-Xavier Thomas.
# You are free to copy, adapt or modify it.
# If you do so, however, leave my name somewhere in the credits, I'd appreciate it ;)

BASEDIR=$(pwd)

function copyconf {
  IN="$BASEDIR/$1"
  OUT="$2/$1"
  if [ -e "$OUT" ]; then
    echo ">>> $OUT exists. Overwrite? (y/N) "
    read _ok
  else
    echo -n ">>> $IN -> $OUT"
    _ok='y'
  fi
  if [[ $_ok == 'y' ]]; then
    rm -rvi "$OUT"
    cp "$IN" "$OUT" >/dev/null 2>&1
  fi
}

function linkconf {
  IN="$BASEDIR/$1"
  OUT="$2/$1"
  if [ -e "$OUT" ]; then
    echo ">>> $OUT exists. Overwrite? (y/N) "
    read _ok
  else
    echo -n ">>> $IN -> $OUT"
    _ok='y'
  fi
  if [[ $_ok == 'y' ]]; then
    rm -rvi "$OUT"
    ln -s "$IN" "$OUT" >/dev/null 2>&1
  fi
}

# Update submodules
echo "Updating submodules..."
git submodule init
git submodule update

# Link configuration
echo "Linking configuration..."
linkconf .oh-my-zsh ~
linkconf .bash_profile ~
linkconf .bashrc ~
linkconf .gdbinit ~
copyconf .gitconfig ~
linkconf .gitbase ~
linkconf .gitignore_global ~
linkconf .lftp ~
linkconf .tmux.conf ~
linkconf .vim ~
linkconf .vimrc ~
linkconf .zshrc ~
linkconf .aliases ~
linkconf .profile ~
linkconf .psqlrc ~
linkconf .multitailrc ~
linkconf fx.zsh-theme ~/.oh-my-zsh/themes
mkdir -p ~/.config && linkconf flake8 ~/.config

# Install Vim bundles
echo "Installing Vim bundles..."
vim +PluginInstall +qall

# Make Vimproc
echo "Compiling Vimproc..."
UNAME=`uname`
if [[ "$UNAME" == "Linux" ]]; then
  cd .vim/bundle/vimproc.vim && make -f make_unix.mak
elif [[ "$UNAME" == "FreeBSD" ]]; then
  cd .vim/bundle/vimproc.vim && make -f make_unix.mak
elif [[ "$UNAME" == "Darwin" ]]; then
  cd .vim/bundle/vimproc.vim && make -f make_mac.mak
else
  echo "Unable to compile Vimproc for your architecture... [$UNAME]"
fi

# Make YCM
if [[ -f ~/.vim/bundle/YouCompleteMe/install.py ]]; then
  echo "Compiling YCM..."
  cd ~/.vim/bundle/YouCompleteMe && ./install.py
fi

# Finish!
echo "All done!"
