#!/usr/bin/env bash

# Let's you check when the internet is back up, and tells you when it is
while true; do
  ping -c 1 -t 10 8.8.8.8

  if [ $? -eq 0 ]; then
    say internet is up
    exit
  fi
done
