#!/bin/sh
# When AC power gets connected, kill swayidle.
# When AC power gets disconnected, start swayidle
printf "Power Check: Initialized\n"
while true; do
  status="$(cat /sys/class/power_supply/AC/online)"
  case "$status" in
    "1")
      if pkill -e swayidle; then
        printf "Power Check: AC connection established, ending screen idle\n" 
      fi ;;
    "0")
     if ! pgrep swayidle >/dev/null; then
       swayidle -w &
       printf "Power Check: AC connection terminated, restarting screen idle\n"
     fi ;;
   esac
   sleep 60
done
