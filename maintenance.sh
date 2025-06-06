#!/bin/bash

# Prints the last update date when it is at least 7 days prior
last_update="$(awk 'END{sub(/\[/,""); print $1}' /var/log/pacman.log | head -c 10)"
last_update_epoch="$(date -d "$last_update" +%s)"
todays_epoch="$(date +%s)"
week_epoch=604800
if [ $(("$todays_epoch")) -ge $(("$last_update_epoch"+"$week_epoch")) ]; then
  printf "Last update: %s\n" "$last_update"
fi

# Prints the system uptime when it's been up for at least 3 days
uptime_epoch="$(uptime -r | awk '{print $2}' | sed 's/[.].*//')"
day_epoch=259200
threedays_epoch=259200
if [ $(("$uptime_epoch")) -ge $(("$threedays_epoch")) ]; then
  uptime_days="$(("$uptime_epoch"/"$day_epoch"))"
  printf "Uptime: %s days\n" "$uptime_days"
fi
