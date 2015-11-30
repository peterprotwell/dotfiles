#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Homebrew

if ! type brew > /dev/null; then
  echo "Homebrew not found, installing..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew installed"
  brew update
fi

#-------------------------------------------------------------------------------
# Packages

packages="ag bash cask cloc coreutils ctags elixir emacs gcc git\
 htop leiningen markdown p7zip python3 rename shellcheck thefuck tree zsh"

for package in $packages; do
  brew install "$package"
done

#-------------------------------------------------------------------------------
# Apps

brew install caskroom/cask/brew-cask

apps="alfred emacs firefox flux gitx google-chrome iterm2 macdown menumeters\
 openoffice paintbrush scroll-reverser sizeup vlc"

for app in $apps; do
  brew cask install "$app"
done

#-------------------------------------------------------------------------------
# zsh

if ! [ -d ~/.oh-my-zsh ]; then
  echo "Cloning oh-my-zsh"
  git clone git@github.com:robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
  echo "oh-my-zsh exists"
fi

if ! [ -L ~/.oh-my-zsh/themes/mikenichols.zsh-theme ]; then
  echo "Linking ZSH theme..."
  ln -s ~/dotfiles/mikenichols.zsh-theme ~/.oh-my-zsh/themes/mikenichols.zsh-theme
else
  echo "ZSH theme linked"
fi

#-------------------------------------------------------------------------------
# rvm

if ! type rvm > /dev/null; then
  echo "Installing rvm..."
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable
else
  echo "rvm installed"
fi

#-------------------------------------------------------------------------------
# Unicorn leap

if ! [ -e  ~/code/unicornleap ]; then
  echo "Installing unicornleap..."
  mkdir -p ~/code
  cd ~/code
  git clone git@github.com:jgdavey/unicornleap.git
  cd unicornleap
  make
  make install
else
  echo "unicornleap installed"
fi
