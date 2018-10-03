#-------------------------------------------------------------------------------
# coreutils

if type brew &> /dev/null; then
  coreutils_dir="$(brew --prefix coreutils)/libexec"

  if [ -d "$coreutils_dir" ]; then
    export PATH="$coreutils_dir/gnubin:$PATH"
    export MANPATH="$coreutils_dir/gnuman:$MANPATH"
  fi
fi

#-------------------------------------------------------------------------------

# From https://blog.ideasynthesis.com/2018/09/24/Disable-Google-Chrome-Sign-In-and-Sync/
defaults write com.google.Chrome SyncDisabled -bool true
defaults write com.google.Chrome RestrictSigninToPattern -string ".*@example.com"

#-------------------------------------------------------------------------------
