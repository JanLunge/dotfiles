# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
	cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}
#create dir and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}
# Download current youtube music playlist
function updateMusic(){
  cd ~/Music/Youtube/
  youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --no-post-overwrites -ciwx --embed-thumbnail --add-metadata --download-archive downloaded.txt --output '%(playlist)s/%(title)s - %(id)s.%(ext)s' PLdbIj_aeQsBZnF-dX8Pk_BrU-AidCUP_G
}
