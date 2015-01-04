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

packages="ag bash cloc coreutils ctags emacs ffmpeg git postgresql python qt\
 rbenv rename ruby-build shellcheck tree youtube-dl zsh"

for package in $packages; do
  brew install "$package"
done

#-------------------------------------------------------------------------------
# Apps

brew install caskroom/cask/brew-cask

apps="dropbox emacs firefox flux gitx google-chrome iterm2 macdown openoffice\
 paintbrush screenhero scroll-reverser sizeup skype steam virtualbox vlc ynab"

for app in $apps; do
  brew cask install "$app"
done
