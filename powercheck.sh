#!/bin/sh
# When AC power gets connected, kill swayidle.
# When AC power gets disconnected, start swayidle
status="$(cat /sys/class/power_supply/AC/online)"
printf "Power Check Status: %s\n" "$status"
case "$status" in
  "1")
    if pkill -e swayidle; then
      printf "Power Check: AC connection established, ending screen idle\n" 
    fi ;;
  "0")
   if ! pgrep -x swayidle; then
     swaymsg exec 'swayidle -w &'
     printf "Power Check: AC connection terminated, restarting screen idle\n"
   fi ;;
esac
