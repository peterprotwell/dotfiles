##
## Mike's .bash_profile file
##

source ~/dotfiles/common.sh

# Download a video from youtube to an mp3
function ytd {
  if [ -e "a.mp3" ]; then
    rm "a.mp3"
  fi
  youtube-dl -o v.flv "$1" && ffmpeg -i v.flv -ab 192k a.mp3 && rm v.flv
}

# Download a video from youtube to an mpg
function ytd {
  if [ -e "a.mpg" ]; then
    rm "a.mpg"
  fi
  youtube-dl -o v.flv "$1" && ffmpeg -i v.flv -ab 192k a.mp3 && rm v.flv
}

# Reload your .bash_profile file while your shell is running
alias resh="source ~/.bash_profile && echo '.bash_profile reloaded'"

#-------------------------------------------------------------------------------

if [[ $(uname) == "Darwin" ]]; then
  alias en="open"
  # Enables colors in Mac OS X iTerm2
  if [ "$TERM" != "dumb" ]; then
    alias ls="ls -G"
  else
    alias ls="ls -p"
  fi
else
  # This is a terrible word to type
  alias en="evince"
fi

export progmike=progran5@programmermike.com:/home2/progran5/
alias sshprm="ssh progran5@programmermike.com"

#-------------------------------------------------------------------------------

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  eval "$(dircolors -b)"
  if [ "$TERM" != "dumb" ]; then
    alias ls='ls --color=auto'
  else
    # Show directories with a slash
    alias ls='ls -p'
  fi
fi

# If not running interactively, don't do anything
if [ -n "$PS1" ] ; then

  # don't put duplicate lines in the history. See bash(1) for more options
  # don't overwrite GNU Midnight Commander's setting of `ignorespace'.
  export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
  # ... or force ignoredups and ignorespace
  export HISTCONTROL=ignoreboth

  # append to the history file, don't overwrite it
  shopt -s histappend

  # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
    xterm-color) color_prompt=yes;;
  esac

  # uncomment for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt
  #force_color_prompt=yes

  if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      # We have color support; assume it's compliant with Ecma-48
      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
      # a case would tend to support setf rather than setaf.)
      color_prompt=yes
    else
      color_prompt=
    fi
  fi

  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
  unset color_prompt force_color_prompt

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
    xterm*|rxvt*)
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
      ;;
    *)
      ;;
  esac

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bash_profile and /etc/profile
  # sources /etc/bash.bash_profile).
  if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

PS1='\w$ '

# This is for Node.js
export PATH="$HOME/local/bin:$PATH"

# Clojure
export PATH="$HOME/.cljr/bin:$PATH"

# My scripts
export PATH="~/dotfiles/bin:$PATH"

# Homebrew
export PATH="/usr/local/bin:$PATH"

export NODE_PATH=/usr/local/lib/node_modules

#-------------------------------------------------------------------------------
# rbenv

if which rbenv >/dev/null; then
  eval "$(rbenv init -)"
fi

#-------------------------------------------------------------------------------

## end .bash_profile

# added by Anaconda3 2.2.0 installer
export PATH="/Users/mike/anaconda/bin:$PATH"
