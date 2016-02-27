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

# requires node and http-server:
#   npm install http-server -g
function serve {
  local port=8080

  if [ "$1" ]; then
    port="$1"
  fi

  http-server ./ -p ${port}
}

function change_shell {
  local new_shell="$1"

  if ! [ -e "$new_shell" ]; then
    echo 'Please enter a valid shell'
    return 1
  fi

  chsh -s "$new_shell" "$(whoami)"
}

#-------------------------------------------------------------------------------
# aliases

# I'm really more of a dog person
alias dog="cat"
alias dogc="pygmentize -g "

# zsh default aliases this to 'ls -l'
alias ll="ls -hAl"

# Shows how much space each directory/file in the current directory is taking up
alias dush="du -sh ./*"

alias sc="shellcheck"

alias underscore2dash='rename "s/_/-/g" ./*'

alias b="bundle"
alias be="bundle exec"
alias ber="bundle exec rake"
alias bers="bundle exec rspec"
alias beru="bundle exec ruby"

# rspec && unicorn
alias ru="bundle exec rspec && unicornleap -s 1.5"
alias rr="rubocop && bundle exec rspec && unicornleap -s 1.5"

# rails stuff
alias ret="RAILS_ENV=test"
alias red="RAILS_ENV=development"
alias rep="RAILS_ENV=production"

alias taildev="tail -f log/development*"
alias tailprod="tail -f log/production*"

# rake aliases
alias mst="bundle exec rake db:migrate:status"
alias tmst="RAILS_ENV=test bundle exec rake db:migrate:status"

alias dcl="bundle exec rake db:drop db:create db:schema:load"
alias dcls="bundle exec rake db:drop db:create db:schema:load db:seed"

alias dcm="bundle exec rake db:drop db:create db:migrate"
alias dcms="bundle exec rake db:drop db:create db:migrate db:seed"

alias tdcl="RAILS_ENV=test bundle exec rake db:drop db:create db:schema:load"
alias tdcls="RAILS_ENV=test bundle exec rake db:drop db:create db:schema:load db:seed"

alias tdcm="RAILS_ENV=test bundle exec rake db:drop db:create db:migrate"
alias tdcms="RAILS_ENV=test bundle exec rake db:drop db:create db:migrate db:seed"

# emacs
alias ce="cask exec"
alias cee="cask exec ecukes"
alias cer="cask exec ert-runner"

# postgresql
alias pginit="initdb /usr/local/var/postgres -E utf8 -U mike"
alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias pgstatus="pg_ctl -D /usr/local/var/postgres status"
alias pg="psql -h localhost -d postgres"

# cd aliases
alias cdA="cd /Applications"
alias cdb="cd ~/books"
alias cdc="cd ~/code"
alias cdcc="cd ~/code/c"
alias cdcco="cd ~/code/coffeescript"
alias cdcj="cd ~/code/javascript"
alias cdcjn="cd ~/code/javascript/node"
alias cdcl="cd ~/code/lisp"
alias cdclj="cd ~/code/clojure"
alias cdcrd="cd ~/code/rails/depot"
alias cdd="cd ~/Downloads"
alias cdD="cd ~/Desktop"
alias cd.="cd ~/dotfiles"
alias cde="cd ~/thoughts/emacs"
alias cdeb="cd ~/emacs-book"
alias cdm="cd ~/code/mikendotio"
alias cdM="cd ~/Movies"
alias cdp="cd ~/Pictures"
alias cdpm="cd ~/code/rails/programmer-mike"
alias cdr="cd ~/code/ruby"
alias cdra="cd ~/code/rails"
alias cdrr="cd ~/code/ruby-refactor"
alias cdr.="cd ~/code/rvm.el"
alias cdrw="cd ~/code/rails/recursewords"
alias cdt="cd ~/thoughts"

# Java command line
alias vb="javac -cp .:junit-4.11.jar:hamcrest-core-1.3.jar *.java"
alias vt="java -cp .:junit-4.11.jar:hamcrest-core-1.3.jar org.junit.runner.JUnitCore VideoStoreTest"

alias ack="ag"

alias un7zip="7z x"

alias g="git"
alias gx="gitx &"

alias pwdp="pwd -P"

alias rmtrash="rm -rf ~/.Trash/*"

alias killspring="ps aux | egrep 'spring (app|server)' | tr -s ' ' | cut -d' ' -f2 | xargs kill -9"

# nice path
alias np="echo \"$PATH\" | tr : '\n'"

#-------------------------------------------------------------------------------
# machine-specific setup

if [ "$(whoami)" = "mike" ]; then
  source ~/dotfiles/home.sh
elif [ "$(whoami)" = "mikenichols" ]; then
  source ~/dotfiles/work.sh
fi

if [ "$(uname)" = "Darwin" ]; then
  source ~/dotfiles/common-mac.sh
elif [ "$(uname)" = "linux-gnu" -o "$(uname)" = "Linux" ]; then
  source ~/dotfiles/common-linux.sh
fi

#-------------------------------------------------------------------------------
# Misc.

# Nicer colors for emacs in terminal
export TERM=xterm-256color

eval "$(thefuck --alias)"

#-------------------------------------------------------------------------------
# rvm

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  # Load RVM into a shell session *as a function*
  source "$HOME/.rvm/scripts/rvm"
fi

#-------------------------------------------------------------------------------

## end common.sh
