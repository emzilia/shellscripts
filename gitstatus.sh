#!/bin/bash
# Loops through all folders in the $HOME/repos directory, running git fetch and saving the result of git status to a variable,
# which is then read and a notification is sent based on the git repo's status.
for dir in $HOME/repos/*/; do
	cd "$dir"
	echo "Entering $dir"
	git fetch
	echo "Changes have been fetched"
	git_results="$(git status)"
	if [[ $(echo "$git_results" | grep "Your branch is behind") ]]; then
		echo "Sending notification: branch is behind"
		notify-send "Branch is behind: $(basename $dir)" "Changes have been fetched and are ready to merge."
	fi
	if [[ $(echo "$git_results" | grep "Your branch is ahead") ]]; then
		echo "Sending notification: branch is ahead"
		notify-send "Branch is ahead: $(basename $dir)" "Changes have been commited and are ready to push."
	fi
	if [[ $(echo "$git_results" | grep "have diverged") ]]; then
		echo "Sending notification: branch has diverged"
		notify-send "Branch has diverged: $(basename $dir)" "Intervention required to reconcile changes."
	fi
	if [[ $(echo "$git_results" | grep "Changes to be committed:") ]]; then
		echo "Sending notification: pending commits"
		notify-send "Branch has pending commits: $(basename $dir)" "Changes have been staged and are ready to commit."
	fi
	if [[ $(echo "$git_results" | grep "Changes not staged for commit:") ]]; then
		echo "Sending notification: unstaged changes"
		notify-send "Branch has unstaged changes: $(basename $dir)" "Changes have been made and are ready to stage."
	fi
done
