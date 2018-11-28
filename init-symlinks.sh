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

if [ -L ~/.ssh/config ]; then
  rm ~/.ssh/config
elif [ -e ~/.ssh/config ]; then
  mv ~/.ssh/config ~/.ssh/backup_of_config
fi

echo "Linking ~/dotfiles/ssh_config as ~/.ssh/config"
mkdir -p ~/.ssh
ln -s ~/dotfiles/ssh_config ~/.ssh/config

if ! [ -d ~/.unicornleap ]; then
  echo "Please install unicornleap"
elif [ -L ~/.unicornleap/sweetjesus.png]; then
  echo "Unicorn leap images already linked"
else
  echo "Linking unicorn leap images"
  ln -s ~/dotfiles/images/phoenix.png ~/.unicornleap/phoenix.png
  ln -s ~/dotfiles/images/flame.png ~/.unicornleap/flame.png
  ln -s ~/dotfiles/images/sweetjesus.png ~/.unicornleap/sweetjesus.png
fi
