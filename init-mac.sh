#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Homebrew

if ! type brew > /dev/null; then
  echo "Homebrew not found, installing..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

#-------------------------------------------------------------------------------
# Packages

packages="ag bash cloc coreutils ctags emacs git icdiff rename shellcheck tree zsh"

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
# rvm

echo "Installing rvm..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable

#-------------------------------------------------------------------------------
# Unicorn leap

mkdir -p ~/code
cd ~/code
git clone git@github.com:jgdavey/unicornleap.git
cd unicornleap
make
make install
