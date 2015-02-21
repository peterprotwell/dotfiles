#!/usr/bin/env bash

# Tells you when the internet is back up after an outage
while true; do
  ping -c 1 -t 10 8.8.8.8

  if [ $? -eq 0 ]; then
    say internet is up
    exit
  fi
done
