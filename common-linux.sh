alias normal-scrolling="xmodmap ~/dotfiles/.Xmodmap"
alias reverse-scrolling="xmodmap ~/dotfiles/.Xmodmap-touchpad"

alias ynab="/home/mike/.wine_YNAB4/drive_c/Program\ Files/YNAB\ 4/YNAB\ 4.exe"

if [ -f ~/dotfiles/.Xmodmap ]; then
  if [ "$XMODMAP_LOADED" = "" ]; then
    xmodmap ~/dotfiles/.Xmodmap
    export XMODMAP_LOADED="1"
  fi
fi
