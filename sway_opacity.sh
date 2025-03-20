#!/bin/sh

swaymsg opacity plus 0.01

if [ $? -eq 0 ]; then
  swaymsg opacity 1
else
  swaymsg opacity 0.95
fi
