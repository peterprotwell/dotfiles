#! /usr/bin/env bash

# From http://www.leancrew.com/all-this/2011/12/more-shell-less-egg/
tr -cs A-Za-z '\n' |
tr A-Z a-z |
sort |
uniq -c |
sort -rn |
head -25
