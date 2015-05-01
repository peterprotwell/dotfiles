#-------------------------------------------------------------------------------
# coreutils

coreutils_dir="$(brew --prefix coreutils)/libexec"

if [ -d "$coreutils_dir" ]; then
  export PATH="$coreutils_dir/gnubin:$PATH"
  export MANPATH="$coreutils_dir/gnuman:$MANPATH"
fi

#-------------------------------------------------------------------------------
