#!/bin/bash
# This script downloads all the videos from a youtube playlist and converts them to mp3 files

# Check if the url has been provided
if [ -z "$1" ]; then
  echo "Please provide a url"
fi

# Check if the url is valid
if ! [[ $1 =~ ^https?://(www\.)?youtube\.com/playlist\?list=.*$ ]]; then
  echo "Please provide a valid url"
  exit 1
fi

# Function do perform playlist download
playlist_download() {
	youtube-dl -i -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata --metadata-from-title "%(artist)s - %(title)s" -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" $1
}

# Download the videos, report success/failure 
if [playlist_download() -eq 0]; then
	echo "The files were downloaded successfully"
	exit 0
else
	echo "There was an error downloading the playlist"
	exit 1
fi

