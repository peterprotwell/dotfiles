#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# xcode command line tools

xcode-select --install

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

apps="emacs google-chrome iterm2 java sizeup"

for app in $apps; do
  brew cask install "$app"
done

#-------------------------------------------------------------------------------
# homebrew packages

packages="clojure coreutils ctags git leiningen postgresql@9.6 rbenv
 the_silver_searcher tree ydiff zsh"

for package in $packages; do
  brew install "$package"
done

# Post-install stuff
brew services start postgresql@9.6

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

## End init-mac-quick.sh
