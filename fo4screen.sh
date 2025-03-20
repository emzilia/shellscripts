#!/usr/bin/env bash

xrandrcheck () {
	local result=$(xrandr --listactivemonitors | awk '/Monitors:/{print $2}')
	echo "$result"
}

xrandroff="xrandr --output DVI-D-0 --off"

xrandreset="xrandr --output DVI-D-0 --auto --left-of DP-0"

while pgrep Fallout4.exe >/dev/null; do
	if [ "$(xrandrcheck)" -eq 2 ]; then
		eval "$xrandroff"
	fi
	sleep 5
done

if [ "$(xrandrcheck)" -eq 1 ]; then
	eval "$xrandreset"
fi

