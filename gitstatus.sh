#!bin/bash
# Loops through all folders in the repos directory, running git fetch and git status and sending a notification if there are pending changes.
for dirs in $HOME/repos/*/; do
	cd "$dirs"
	git fetch
	if [[ $(git status | grep "Your branch is behind") ]]; then
		notify-send "Your branch is behind: $(basename $dirs)" "Changes have been fetched and are ready to merge."
	fi
	if [[ $(git status | grep "Your branch is ahead") ]]; then
		notify-send "Your branch is ahead: $(basename $dirs)" "Changes have been commited and are ready to push."
	fi
	if [[ $(git status | grep "have diverged") ]]; then
		notify-send "Your branch has diverged: $(basename $dirs)" "Intervention required to reconcile changes."
	fi
done
