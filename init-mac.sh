#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Homebrew

if ! type brew > /dev/null; then
  echo "Homebrew not found, installing..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew already installed"
  brew update
fi

#-------------------------------------------------------------------------------
# Packages

packages="bash cask cloc coreutils ctags elixir emacs ffmpeg gcc git htop-osx
 leiningen markdown p7zip postgresql rbenv rename ruby-build shellcheck
 the_silver_searcher thefuck tree youtube-dl zsh"

for package in $packages; do
  brew install "$package"
done

# Post-install stuff
if ! psql -l &> /dev/null; then
  echo "Starting posgresql..."
  brew services start postgresql
else
  echo "postgresql already started"
fi

#-------------------------------------------------------------------------------
# Apps

apps="alfred emacs firefox flux gitx google-chrome hipchat iterm2 macdown menumeters\
 openoffice paintbrush scroll-reverser sizeup steam sublime-text utorrent vlc"

for app in $apps; do
  brew cask install "$app"
done

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
