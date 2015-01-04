#!/usr/bin/env bash

# Sets up all my stuff on a Debian based linux, like Ubuntu

cd ~

delete-these="examples.desktop Public Videos"
for element in delete-these; do
  if [ -e "$element" ]; then
    rm -rf "$element"
  fi
done

# TODO: find out if this is Debian, Fedora, Cygwin, or Darwin based
os-name="$(uname)"
if [ "$os-name" eq "Darwin" ]; then
  echo "You're on a mac. Go run init-mac.sh instead."
  exit
elif [ "$os-name" == "linux-gnu" ]; then
  install-command="yes | sudo apt-get install"
  yes | sudo apt-get update
else
  echo "Unknown OS name: '$os-name'"
  exit
fi

# chrome
# "$install-command" chromium-browser flashplugin-nonfree

# emacs
"$install-command" emacs

# git
# "$install-command" git-core git-gui git-docs

# vlc
"$install-command" vlc libdvdread4
sudo /usr/share/doc/libdvdread4/install-css.sh
sudo cp /usr/share/applications/vlc.desktop /usr/share/applications/totem.desktop

# music
"$install-command" ffmpeg libavcodec-extra-52 youtube-dl
sudo youtube-dl -U
sudo youtube-dl -U

# ruby
"$install-command" ruby rubygems

# rails dependencies
"$install-command" build-essential bison openssl libreadline6 \
  libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev \
  libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev libcurl4-gnutls-dev
