#!bin/bash
# Loops through all folders in the repos directory, running git fetch and git status and sending a notification if there are pending changes.
for d in $HOME/repos/*/; do
	cd "$d"
	git fetch
	if [[ $(git status | grep "Your branch is behind") ]]; then
		notify-send "A remote repository has been updated: $(basename $d)"
	fi
done
