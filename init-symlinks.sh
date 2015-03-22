#!/usr/bin/env bash

function make_symlink {
  if [ -L ~/"$1" ]; then
    rm ~/"$1"
  elif [ -e ~/"$1" ]; then
    echo "$1" already exists.
    return
  fi

  echo "Linking ~/dotfiles/$1 as ~/$1"
  ln -s ~/dotfiles/"$1" ~
}

links=".emacs .emacs.d .zprofile .zshrc .bash_profile .bashrc .gitconfig .irbrc .gemrc"

for link in $links; do
  make_symlink "$link"
done
