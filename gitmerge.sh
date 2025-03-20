#!/bin/bash
# Loops through all folders in the $HOME/repos directory, running git fetch and saving the result of git status to a variable, which is then read and a notification is sent based on the git repo's status.
for dir in $HOME/repos/*/; do
	cd "$dir"
	echo "Entering $dir"
	git fetch
	echo "Changes have been fetched"
	git_results="$(git status)"
	if [[ $(echo "$git_results" | grep "Your branch is behind") ]]; then
		echo "Sending notification: branch is behind"
		notify-send "Branch is behind: $(basename $dir)" "Changes are being merged now"
		git merge
	fi
done
