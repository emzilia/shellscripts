#!/bin/bash
# Switch between connection profiles with dmenu

choice="$(nmcli -f NAME c show | tail -n +2 | dmenu)"

active="$(nmcli -f NAME c show --active | tail -n +2)"

if [ "$choice" = "$active" ]; then
	echo "You're already connected to $active"
else 
	echo "Connecting to: $choice"
	nmcli c up $choice
fi
