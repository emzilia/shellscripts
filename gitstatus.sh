#!/bin/bash
# Loops through all folders in the $HOME/repos directory, running git fetch
# and saving the result of git status to a variable, which is then read and a
# notification is sent based on the git repo's status.

for dir in $HOME/repos/*/; do
  echo "Changes are being fetched from $dir"
  git -C $dir fetch &
  git_results="$(git -C $dir status &)"
  case "$git_results" in
    *"Your branch is behind"*)
      echo "Sending notification: branch is behind"
      notify-send "$(basename $dir) is behind" 
      ;;
    *"Your branch is ahead"*)
      echo "Sending notification: branch is ahead"
      notify-send "$(basename $dir) is ahead" 
      ;;
    *"have diverged"*)
      echo "Sending notification: branch has diverged"
      notify-send "$(basename $dir) has diverged" 
      ;;
    *"Changes to be comm"*)
      echo "Sending notification: pending commits"
      notify-send "$(basename $dir) has uncommited changes" 
      ;;
    *"Changes not staged"*)
      echo "Sending notification: unstaged changes"
      notify-send "$(basename $dir) has unstaged changes" 
      ;;
  esac
done
