#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Homebrew

if ! type brew > /dev/null; then
  echo "Homebrew not found, installing..."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

brew update
brew upgrade

#-------------------------------------------------------------------------------
# Packages

packages="ag bash cloc coreutils ctags emacs git icdiff rbenv rename ruby-build shellcheck tree zsh"

for package in $packages; do
  brew install "$package"
done

#-------------------------------------------------------------------------------
# Apps

brew install caskroom/cask/brew-cask

apps="emacs firefox gitx google-chrome iterm2 macdown menumeters\
 openoffice paintbrush scroll-reverser sizeup skype vlc"

for app in $apps; do
  brew cask install "$app"
done
