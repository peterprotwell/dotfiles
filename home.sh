##
## Mike's home config file
##

#-------------------------------------------------------------------------------
# functions

# Download a video from youtube to an mp3
function ytd {
  if [ -e "a.mp3" ]; then
    rm "a.mp3"
  fi
  youtube-dl -o v.flv "$1" && ffmpeg -i v.flv -ab 192k a.mp3 && rm v.flv
}

#-------------------------------------------------------------------------------
# aliases

alias cdJ="cd ~/Documents/job"
alias cdm="cd ~/code/rails/movie-trailer-bingo"
