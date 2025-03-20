#!/usr/bin/env bash

# Runs xrandr --listactivemonitors and captures the number of actives monitors, 1 or 2
xrandrcheck () {
	local result=$(xrandr --listactivemonitors | awk '/Monitors:/{print $2}')
	echo "$result"
}

# Disables secondary monitor
xrandroff="xrandr --output DVI-D-0 --off"

# Re-enables secondary monitor and places it back in its spot
xrandreset="xrandr --output DVI-D-0 --auto --left-of DP-0"

# Runs script to restart polybar
resetbar="~/.config/polybar/launch.sh"

# While Fallout 4 is running, if 2 monitors are active disable the secondary one
# Checks every 5 seconds
while pgrep Fallout4.exe >/dev/null; do
	if [ "$(xrandrcheck)" -eq 2 ]; then
		eval "$xrandroff"
	fi
	sleep 5
done

# If Fallout 4 isn't running and only 1 monitor is active, re-enable the secondary
# monitor and reset polybar
if [ "$(xrandrcheck)" -eq 1 ]; then
	eval "$xrandreset"
	eval "$resetbar"
fi

