#!/usr/bin/env bash

process="Fallout4.exe"

xrandrcheck=$(xrandr --listactivemonitors | awk '/Monitors:/{print $2}')

xrandroff="xrandr --output DVI-D-0 --off"

xrandreset="xrandr --output DVI-D-0 --auto --left-of DP-0"

while pgrep "$process" >/dev/null; do
	if [ "$xrandrcheck" -eq 2 ]; then
		eval "$xrandroff"
	fi
	sleep 1
done

eval "$xrandreset"
