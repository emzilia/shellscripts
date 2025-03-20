#!/bin/bash

# When run, creates a barrier the mouse can't traverse, for full-screen
# apps that don't capture the mouse properly
command="xpointerbarrier"

# Game process to watch for
process="Fallout4.exe"

# While game's process is running, if xpointerbarrier isn't running, run it
while pgrep $process >/dev/null; do
	if ! pgrep "$command" >/dev/null; then
		$command 0 0 0 0 &
	fi
	sleep 5
done

# If game's process isn't running and xpointerbarrier still is, kill it
if pgrep "$command" >/dev/null; then
	pkill "$command"
fi

