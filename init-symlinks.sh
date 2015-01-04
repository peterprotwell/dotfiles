#!/usr/bin/env bash

function make_symlink {
  if [ -L ~/"$1" ] ; then
    rm ~/"$1"
  fi

  ln -s ~/dotfiles/"$1" ~
}

# emacs
make_symlink .emacs
make_symlink .emacs.d

# zsh
make_symlink .zprofile
make_symlink .zshrc

# bash
make_symlink .bash_profile
make_symlink .bashrc

# git
make_symlink .gitconfig

# ruby
make_symlink .irbrc
make_symlink .gemrc

echo "Symlinks created."
