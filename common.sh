##
## Mike's common shell config file
##

# There can be only one
export EDITOR="emacs -q"
alias e="emacsclient -n"

#-------------------------------------------------------------------------------
# functions

# change up a directory
function cu {
  cd ../"$1"
}

function fn {
  find . -name "*$1*"
}

function mkcd {
  mkdir "$1" && cd "$1"
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
  local port=1234

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

function oci {
  if [ -e "coverage/index.html" ]; then
    open coverage/index.html
  elif [ -e "cover/excoveralls.html" ]; then
    open cover/excoveralls.html
  elif [ -e "coverage/lcov-report/index.html" ]; then
    open coverage/lcov-report/index.html
  else
    echo "Nope."
  fi
}

function workfromhome {
  if grep "\[user\]" .git/config > /dev/null; then
    echo "Already set up"
  else
    echo "Setting work email for this repo..."
    echo "[user]\n  email = me@miken.io\n  name = Mike Nichols" >> .git/config
  fi
}

#-------------------------------------------------------------------------------
# aliases

# I'm really more of a dog person
alias dog="cat"
alias dogc="pygmentize -g "

# zsh default aliases this to 'ls -l'
alias ll="ls -hAl"

alias o=open

# Shows how much space each directory/file in the current directory is taking up
alias dush="du -sh ./*"

alias sc="shellcheck"

alias underscore2dash='rename "s/_/-/g" ./*'

# nice path
alias np="echo \"$PATH\" | tr : '\n'"

# homebrew update all
alias hbua="brew update && brew upgrade"

# bundler
alias b="bundle check || bundle install"
alias bi="bundle install"
alias bus="bundle update --source"
alias bu="bundle update"
alias be="bundle exec"
alias ber="bundle exec rake"
alias bers="bundle exec rspec"
alias beru="bundle exec ruby"

# rspec && unicorn
alias ru="bundle exec rspec && unicornleap -s 1.5"
alias rr="bundle exec rubocop -D && bundle exec rspec && unicornleap -s 1.5"

# rails stuff
alias ret="RAILS_ENV=test"
alias red="RAILS_ENV=development"
alias rep="RAILS_ENV=production"

alias taildev="tail -f log/development*"
alias tailprod="tail -f log/production*"

alias bs="bin/start"

# rake aliases
alias mst="bundle exec rake db:migrate:status"

alias dcl="bundle exec rake db:drop db:create db:schema:load"
alias dcls="bundle exec rake db:drop db:create db:schema:load db:seed"

alias dcm="bundle exec rake db:drop db:create db:migrate"
alias dcms="bundle exec rake db:drop db:create db:migrate db:seed"

# mix / elixir
alias mc="mix compile"
alias mch="mix coveralls.html"
alias met="MIX_ENV=test"
alias med="MIX_ENV=dev"
alias me="mix espec"
alias mdg="mix deps.get"
alias mps="mix phoenix.server"
alias mpr="mix phoenix.routes"

alias imps="iex -S mix phoenix.server"
alias ie="iex -S mix espec"

alias ee="mix credo --strict && mix espec --cover && unicornleap -s 1.2 --unicorn phoenix.png --sparkle flame.png"
alias eee="mix credo --strict && mix espec --cover && npm test && unicornleap -s 1.2 --unicorn phoenix.png --sparkle flame.png"
alias eov="mix coveralls.html; open cover/excoveralls.html"

# emacs
alias ce="cask exec"
alias cee="cask exec ecukes"
alias cer="cask exec ert-runner"

# docker
alias di="docker images"
alias dp="docker ps -a"
alias dbuild="docker build -t $(basename $(pwd)) ."
alias drun="docker run -p 9001:4000 -v $(pwd):/$(basename $(pwd)) $(basename $(pwd))"
alias dcb="docker-compose build"
alias dcu="docker-compose up"
alias dcbu="docker-compose build && docker-compose up"

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
alias cdcj="cd ~/code/javascript"
alias cdcl="cd ~/code/lisp"
alias cdclj="cd ~/code/clojure"
alias cdd="cd ~/Downloads"
alias cdD="cd ~/Desktop"
alias cd.="cd ~/dotfiles"
alias cde="cd ~/thoughts/emacs"
alias cdm="cd ~/code/mikendotio"
alias cdM="cd ~/Movies"
alias cdp="cd ~/Pictures"
alias cdpm="cd ~/code/rails/programmer-mike"
alias cdr="cd ~/code/ruby"
alias cdra="cd ~/code/rails"
alias cdrr="cd ~/code/ruby-refactor"
alias cdrw="cd ~/code/rails/recursewords"
alias cdt="cd ~/thoughts"

# Java command line
alias vb="javac -cp .:junit-4.11.jar:hamcrest-core-1.3.jar *.java"
alias vt="java -cp .:junit-4.11.jar:hamcrest-core-1.3.jar org.junit.runner.JUnitCore VideoStoreTest"

alias un7zip="7z x"

alias g="git"
alias gx="gitx &"

alias pwdp="pwd -P"

alias killspring="ps aux | egrep 'spring (app|server)' | tr -s ' ' | cut -d' ' -f2 | xargs kill -9"

alias syncmusic="rsync -vr --size-only --delete /Volumes/yudkowsky/home/Music/iTunes/ ~/Music/iTunes"

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
# Docker

# if [[ "$(docker-machine status default)" == "Running" ]]; then
#  eval "$(docker-machine env default)"
# fi

#-------------------------------------------------------------------------------
# Misc.

# Nicer colors for emacs in terminal
export TERM=xterm-256color

if type fuck &> /dev/null; then
  eval "$(thefuck --alias)"
fi

#-------------------------------------------------------------------------------
# rbenv

if type rbenv &> /dev/null; then
  eval "$(rbenv init -)"
fi

#-------------------------------------------------------------------------------

# Seriously?
export HOMEBREW_NO_ANALYTICS=1

## end common.sh
