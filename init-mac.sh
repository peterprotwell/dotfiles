#!/usr/bin/env bash

# 1. Install xcode
# 2. Add ssh key to github
# 3. Clone dotfiles
# 4. Run this script

#-------------------------------------------------------------------------------
# xcode command line tools

if [ "$(xcode-select -p)" = '/Applications/Xcode.app/Contents/Developer' ]; then
  echo 'xcode or command line tools already installed.'
else
  echo 'Please install xcode and add your ssh key to github before running this script.'
  exit 1
fi

#-------------------------------------------------------------------------------
# homebrew

if ! type brew > /dev/null; then
  echo "Homebrew not found, installing..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew already installed"
fi

#-------------------------------------------------------------------------------
# homebrew cask apps

apps="alfred emacs firefox flux google-chrome iterm2 java libreoffice macdown
 paintbrush scroll-reverser sizeup slack steam sublime-text vlc yujitach-menumeters"

for app in $apps; do
  brew cask install "$app"
done

#-------------------------------------------------------------------------------
# homebrew packages

packages="bash cask cloc clojure coreutils ctags ffmpeg gcc git haskell-stack htop
 leiningen markdown node p7zip postgresql rbenv rename sbt shellcheck
 the_silver_searcher thefuck tree ydiff youtube-dl zsh"

for package in $packages; do
  brew install "$package"
done

# Post-install stuff
brew services start postgresql

#-------------------------------------------------------------------------------
# zsh

if ! [ -d ~/.oh-my-zsh ]; then
  echo "Cloning oh-my-zsh..."
  git clone git@github.com:robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
  echo "oh-my-zsh already exists"
fi

if ! [ -L ~/.oh-my-zsh/themes/mikenichols.zsh-theme ]; then
  echo "Linking zsh theme..."
  ln -s ~/dotfiles/mikenichols.zsh-theme ~/.oh-my-zsh/themes/mikenichols.zsh-theme
else
  echo "zsh theme already linked"
fi

if [ "$SHELL" = "/usr/local/bin/zsh" ]; then
  echo "zsh already set as login shell"
else
  sudo chsh -s "/usr/local/bin/zsh" "$(whoami)"
fi

#-------------------------------------------------------------------------------
# Unicorn leap

if ! [ -e  ~/code/unicornleap ]; then
  echo "Installing unicornleap..."
  mkdir -p ~/code
  cd ~/code
  git clone git@github.com:jgdavey/unicornleap.git
  cd unicornleap
  make && make install
else
  echo "unicornleap already installed"
fi

#-------------------------------------------------------------------------------
# Symlinks

~/dotfiles/init-symlinks.sh

## End init-mac.sh
