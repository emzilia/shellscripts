#!/bin/bash
# This script downloads all the videos from a youtube playlist and converts them to mp3 files

# Check if the url has been provided
if [ -z "$1" ]; then
  echo "Please provide a url"
  exit 1
fi

# Check if the url is valid
if ! [[ $1 =~ ^https?://(www\.)?youtube\.com/playlist\?list=.*$ ]]; then
  echo "Please provide a valid url"
  exit 1
fi

# Download the videos
youtube-dl -i -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata --metadata-from-title "%(artist)s - %(title)s" -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" $1

# Check if the download was successful
if [ $? -ne 0 ]; then
  echo "There was an error downloading the videos"
  exit 1
fi

echo "The files were downloaded successfully"
exit 0
