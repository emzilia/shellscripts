#!/bin/sh

# Process to watch for
process="Fallout4.exe"

# Captures the names of primary and secondary monitors
primarymonitor="$(xrandr --listactivemonitors | awk '/0:/{print $4}')"
secondarymonitor="$(xrandr --listactivemonitors | awk '/1:/{print $4}')"

# Captures the number of actives monitors, 1 or 2
xrandrcheck () {
	result="$(xrandr --listactivemonitors | awk '/Monitors:/{print $2}')"
	echo "${result}"
}

# Disables secondary monitor
xrandroff="xrandr --output ${secondarymonitor} --off"

# Re-enables secondary monitor and places it back in its spot
xrandreset="xrandr --output ${secondarymonitor} --auto --left-of ${primarymonitor}"

# Runs script to restart polybar
resetbar="${HOME}/.config/polybar/launch.sh"

# While Fallout 4 is running, if 2 monitors are active disable the secondary one
# Checks every 5 seconds
while pgrep "${process}" >/dev/null; do
	if [ "$(xrandrcheck)" -eq 2 ]; then
		eval "${xrandroff}"
	fi
	sleep 5
done

# If Fallout 4 isn't running and only 1 monitor is active, re-enable the secondary
# monitor and reset polybar
if [ "$(xrandrcheck)" -eq 1 ]; then
	eval "${xrandreset}"
	eval "${resetbar}"
fi

