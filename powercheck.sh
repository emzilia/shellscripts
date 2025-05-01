#!/bin/sh

printf "Power Check: Initialized\n"

while [ 1 ]; do
  status="$(cat /sys/class/power_supply/AC/online)"
  case "$status" in
    "1")
      if pkill -e swayidle; then
        printf "Power Check: AC connection established, ending screen idle\n" 
      fi
      ;;
    "0")
     if ! pgrep -l swayidle >/dev/null; then
       swayidle -w &
       printf "Power Check: AC connection terminated, restarting screen idle\n"
     fi
     ;;
   esac
   sleep 60
done
