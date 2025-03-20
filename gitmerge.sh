#!/bin/bash
# Loops through all folders in the $HOME/repos directory, running 
# git fetch and saving the result of git status to a variable, which 
# is then read and a notification is sent based on the git repo's status.

for dir in $HOME/repos/*/; do
  echo "Changes are being fetched from $dir"
  git -C $dir fetch
  git_results="$(git -C $dir status)"
  if [[ $(echo "$git_results" | grep "Your branch is behind") ]]; then
    echo "Sending notification: branch is behind"
    notify-send "$(basename $dir) is being merged now" "oh mon dieu ça arrive"
    echo "Changes are being merged"
    git -C $dir merge
  fi
done
