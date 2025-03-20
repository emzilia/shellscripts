
#! /bin/bash

# Display the user's Hostname, Motherboard, packages installed, uptime, and a small ACII graphic

echo "Hostname: $(hostname)"
echo "Motherboard: $(dmidecode -s baseboard-product-name)"
echo "Packages installed: $(dpkg --get-selections | wc -l)"
echo "Uptime: $(uptime | awk '{print $3,$4}' | sed 's/,//')"
echo "  _____ _                 _
 |  ___(_)               | |
 | |__  _ _ __ ___  _ __ | | ___  ___
 |  __|| | '_ ` _ \| '_ \| |/ _ \/ __|
 | |___| | | | | | | |_) | |  __/\__ \
 \____/|_|_| |_| |_| .__/|_|\___||___/
                   | |
                   |_|"
