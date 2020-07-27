if [ -f ~/dotfiles/.zprofile ]; then
  source ~/dotfiles/.zprofile
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
