#!/bin/sh

wallpaper_list=$(find "$PICTURES"/Wallpapers -maxdepth 1 -type f -name '*.jpg' -printf '%P ' -o -name '*.png' -printf '%P ')

number_of_wallpapers=$(echo $wallpaper_list | wc -w)

random_number=$(shuf -i1-"$number_of_wallpapers" -n1)

selected_wallpaper=$(echo $wallpaper_list | awk '{print $'$random_number'}')

printf "Setting wallpaper to: %s\n" $selected_wallpaper
swaymsg 'output * bg '$PICTURES'/Wallpapers/'$selected_wallpaper' stretch'

exit 0
