##
## Mike's home config file
##

#-------------------------------------------------------------------------------
# functions

# Download a video or playlist from youtube to an mp3
function ytd {
  youtube-dl -o '%(title)s.%(ext)s' --yes-playlist -x --audio-format mp3 --audio-quality 192k "$1"
}

#-------------------------------------------------------------------------------
# aliases

alias cdJ="cd ~/Documents/job"
alias cdmtb="cd ~/code/rails/movie-trailer-bingo"
