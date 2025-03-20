#!/bin/bash
# Loops through all folders in the repos directory, running git fetch and git status and sending a notification if there are pending changes.
for dir in $HOME/repos/*/; do
	cd "$dir"
	git fetch
	git_results="$(git status)"
	if [[ $(echo "$git_results" | grep "Your branch is behind") ]]; then
		notify-send "Your branch is behind: $(basename $dir)" "Changes have been fetched and are ready to merge."
	fi
	if [[ $(echo "$git_results" | grep "Your branch is ahead") ]]; then
		notify-send "Your branch is ahead: $(basename $dir)" "Changes have been commited and are ready to push."
	fi
	if [[ $(echo "$git_results" | grep "have diverged") ]]; then
		notify-send "Your branch has diverged: $(basename $dir)" "Intervention required to reconcile changes."
	fi
	if [[ $(echo "$git_results" | grep "Changes to be committed:") ]]; then
		notify-send "Your branch has pending commits: $(basename $dir)" "Changes have been staged and are ready to commit."
	fi
	if [[ $(echo "$git_results" | grep "Changes not staged for commit:") ]]; then
		notify-send "Your branch has unstaged changes: $(basename $dir)" "Changes have been made and are ready to stage."
	fi
done
