#!/bin/bash
# Loops through all folders in the $HOME/repos directory, running git fetch
# and saving the result of git status to a variable, which is then read and a
# notification is sent based on the git repo's status.

for dir in $HOME/repos/*/; do
  echo "Changes are being fetched from $dir"
  git fetch
  git_results="$(git -C $dir status)"
  if [[ $(echo "$git_results" | grep "Your branch is behind") ]]; then
    echo "Sending notification: branch is behind"
	notify-send "$(basename $dir) is behind" "le temps de tirer"
  fi
  if [[ $(echo "$git_results" | grep "Your branch is ahead") ]]; then
    echo "Sending notification: branch is ahead"
	notify-send "$(basename $dir) is ahead" "le temps de pousser"
  fi
  if [[ $(echo "$git_results" | grep "have diverged") ]]; then
    echo "Sending notification: branch has diverged"
	notify-send "$(basename $dir) has diverged" "oh putain, c'est énervant"
  fi
  if [[ $(echo "$git_results" | grep "Changes to be comm") ]]; then
    echo "Sending notification: pending commits"
	notify-send "$(basename $dir) has uncommitted changes" "je devrais le faire bientôt"
  fi
  if [[ $(echo "$git_results" | grep "Changes not staged") ]]; then
    echo "Sending notification: unstaged changes"
	notify-send "$(basename $dir) has unstaged changes" "qu'est-ce que je faisais?"
  fi
done
