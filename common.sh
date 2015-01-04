##
## Mike's common shell config file
##

# There can be only one
export EDITOR="emacs -q"
alias ec="emacsclient -n"

#-------------------------------------------------------------------------------
# functions

# change up a directory
function cu {
  cd ../"$1"
}

function mkcd {
  mkdir "$1" && cd "$1"
}

# nice path
function np {
  echo "$PATH" | tr : "\n"
}

# Ignore RubyMine created files
function ignorerm {
  echo ".idea/*" >> .git/info/exclude
  echo "Ignoring RubyMine project files."
}

# Rename in current directory
function rn {
  rename -n "s/$1/$2/g" ./*
}

function hpg {
  history | grep "$1"
}

function hpgw {
  history | grep "\b$1\b"
}

function biggest {
  if type gsort > /dev/null; then
    du -sh ./* | gsort -h -r | head -15
  else
    du -sh ./* | grep -e "\d\+G" | sort -n -r | head -10
    du -sh ./* | grep -e "\d\+M" | sort -n -r | head -10
  fi
}

function make_symlink_safe {
  if [ -h "$2" ]; then
    echo "Symlink $2 already exists"
  elif [ -f "$2" ]; then
    echo "File $2 already exists"
  elif [ -e "$2" ]; then
    echo "Something $2 already exists"
  else
    echo "Linking $2 as $1"
    ln -s "$1" "$2"
  fi
}

function gh {
  local orig_dir="$(pwd)"

  while ! [ -e .git ]; do
    cd ..

    if [ "$(pwd)" = '/' ]; then
      cd "$orig_dir"
      echo 'Not in a git repo'
      return 1
    fi
  done

  local repo_git_url=$(grep -o -m 1 'git@.*' .git/config)
  local repo_url=${repo_git_url/git\@github\.com\:/https://github.com/}

  cd "$orig_dir"
  open "$repo_url"
}

function agi {
  ag $(echo "$*" | sed 's/ / --ignore /g')
}

#-------------------------------------------------------------------------------
# aliases

# I'm really more of a dog person
alias dog="cat"

# zsh default aliases this to 'ls -l'
alias ll="ls -hAl"

# Shows how much space each directory/file in the current directory is taking up
alias dush="du -sh ./*"

alias sc="shellcheck"

alias underscore2dash='rename "s/_/-/g" ./*'

# Ruby
alias rubyupgrade="rbenv install && gem install bundler && bundle"
alias rubyupdate="rubyupgrade"

# Rails stuff
alias b="bundle"
alias be="bundle exec"
alias ber="bundle exec rake"
alias bers="bundle exec rspec"
alias beru="bundle exec ruby"

alias taildev="tail -f log/development*"

alias mst="bundle exec rake db:migrate:status"

alias dcl="bundle exec rake db:drop db:create db:schema:load"
alias dclm="bundle exec rake db:drop db:create db:schema:load db:migrate"
alias dcls="bundle exec rake db:drop db:create db:schema:load db:seed"

# test versions
alias tdcl="RAILS_ENV=test bundle exec rake db:drop db:create db:schema:load"
alias tdclm="RAILS_ENV=test bundle exec rake db:drop db:create db:schema:load db:migrate"

# postgresql
if type postgres > /dev/null; then
  alias pginit="initdb /usr/local/var/postgres -E utf8 -U mike"
  alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
  alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
  alias pgstatus="pg_ctl -D /usr/local/var/postgres status"
  alias pg="psql -h localhost -d postgres"
fi

# Doesn't work
# alias fuckit="sudo \$(history 1 | cut -d ' ' -f7)"

# cd aliases
alias cdb="cd ~/books"
alias cdc="cd ~/code"
alias cdcc="cd ~/code/c"
alias cdcco="cd ~/code/coffeescript"
alias cdcj="cd ~/code/javascript"
alias cdcjn="cd ~/code/javascript/node"
alias cdcl="cd ~/code/lisp"
alias cdclj="cd ~/code/clojure"
alias cdcru="cd ~/code/ruby/"
alias cdcr="cd ~/code/rails/"
alias cdcrd="cd ~/code/rails/depot"
alias cdd="cd ~/Downloads"
alias cdD="cd ~/Desktop"
alias cd.="cd ~/dotfiles"
alias cde="cd ~/.emacs.d"
alias cdM="cd ~/Movies"
alias cdp="cd ~/Pictures"
alias cdpm="cd ~/code/rails/programmer-mike"
alias cdt="cd ~/thoughts"

# Java command line
alias vb="javac -cp .:junit-4.11.jar:hamcrest-core-1.3.jar *.java"
alias vt="java -cp .:junit-4.11.jar:hamcrest-core-1.3.jar org.junit.runner.JUnitCore VideoStoreTest"

alias ack="ag"

alias un7zip="7z x"

alias gi="git icdiff"
alias gx="gitx &"

#-------------------------------------------------------------------------------
# machine-specific setup

if [ "$(whoami)" = "mike" ]; then
  source ~/dotfiles/home.sh
elif [ "$(whoami)" = "mnichols" ]; then
  source ~/dotfiles/work.sh
fi

if [ "$(uname)" = "Darwin" ]; then
  source ~/dotfiles/common-mac.sh
elif [ "$(uname)" = "linux-gnu" -o "$(uname)" = "Linux" ]; then
  echo "you're on linux"
fi

#-------------------------------------------------------------------------------
# homebrew github api token

export HOMEBREW_GIHUB_API_TOKEN="ea28a82b75aa61b2d36d2c3a647695a11e896bfd"

#-------------------------------------------------------------------------------

## end common.sh
