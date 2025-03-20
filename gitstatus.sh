#!bin/bash
# Loops through all folders in the repos directory, running git fetch and git status and sending a notification if there are pending changes.
for dir in $HOME/repos/*/; do
	cd "$dir"
	git fetch
	if [[ $(git status | grep "Your branch is behind") ]]; then
		notify-send "Your branch is behind: $(basename $dir)" "Changes have been fetched and are ready to merge."
	fi
	if [[ $(git status | grep "Your branch is ahead") ]]; then
		notify-send "Your branch is ahead: $(basename $dir)" "Changes have been commited and are ready to push."
	fi
	if [[ $(git status | grep "have diverged") ]]; then
		notify-send "Your branch has diverged: $(basename $dir)" "Intervention required to reconcile changes."
	fi
done
