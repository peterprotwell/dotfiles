#!/usr/bin/env bash

music_player="/media/mike/X1/m"
if ! [ -e "$music_player" ]; then
  echo "Please plug in your Personal Music Player"
  exit 1
fi

rsync -vr --size-only --delete ~/Music/*.m3u "$music_player/.."

rsync -vr --size-only --delete ~/Music/m/ "$music_player"
