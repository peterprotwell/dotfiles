##
## Mike's home config file
##

#-------------------------------------------------------------------------------
# functions

# Download a video or playlist from youtube to an mp3
function ytd {
  youtube-dl -o '%(title)s.%(ext)s' --format best --ignore-errors --yes-playlist -x --audio-format mp3 --audio-quality 192k "$1"
}

function ytdv {
  youtube-dl -o '%(title)s.%(ext)s' --ignore-errors --yes-playlist --recode-video mp4 "$1"
}

#-------------------------------------------------------------------------------
# aliases

alias cdJ="cd ~/Documents/job"
alias cdmtb="cd ~/code/rails/movie-trailer-bingo"
alias cda="cd ~/code/actionizer"
alias cder="cd ~/code/elixir/rumbl"

#-------------------------------------------------------------------------------
# games

export D2_SAVE_DIR="/Applications/Games.localized/Diablo 2.app/Contents/Resources/drive_c/Program Files/Diablo II/Save"
cdd2="cd $D2_SAVE_DIR"
