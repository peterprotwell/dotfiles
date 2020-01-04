#! /usr/bin/env bash

max="200"
text="the quick brown fox jumps over the lazy dog"

echo "normal"
for ((i=1;i<=$max;i++)) do
  echo "$(tput setaf $i)$i: $text"
done

for ((i=1;i<=$max;i++)) do
  echo "$(tput bold; tput setaf $i)$i: $text"
done
