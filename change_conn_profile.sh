#!/bin/bash
# Switch between connection profiles with dmenu

list="$(nmcli -f NAME c show | tail -n +2)"

choice="$(echo "$list" | dmenu)"

active="$(nmcli -f NAME c show --active | tail -n +2)"

if [ "$choice" = "$active" ]; then
	echo "You're already connected to $active"
elif [[ "$list" = *"$choice"* ]]; then
	echo "Connecting to: $choice"
	nmcli c up $choice
else
	echo "Profile $choice not found"
fi
