##
## Mike's home config file
##

#-------------------------------------------------------------------------------
# functions

# Download a video or playlist from youtube to an mp3
function ytd {
  youtube-dl -o '%(title)s.%(ext)s' --ignore-errors --yes-playlist -x --audio-format mp3 --audio-quality 192k "$1"
}

function ytdv {
  youtube-dl -o '%(title)s.%(ext)s' --ignore-errors --yes-playlist --recode-video mp4 "$1"
}

#-------------------------------------------------------------------------------
# aliases

alias cdJ="cd ~/Documents/job"
alias cdmtb="cd ~/code/rails/movie-trailer-bingo"
alias cda="cd ~/code/actionizer"
