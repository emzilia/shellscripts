#! bin/bash
# Check if there are pending commits from the remote repository
cd $HOME/repos/pwshpro
git fetch
git status

if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
    # Send a notification
    notify-send "There are pending commits from the remote repository: pwshpro"
fi

cd $HOME/repos/startpage
git fetch
git status

if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
    # Send a notification
    notify-send "There are pending commits from the remote repository: startpage"
fi

cd $HOME/repos/jspot
git fetch
git status


if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
    # Send a notification
    notify-send "There are pending commits from the remote repository: startpagev2"
fi

cd $HOME/repos/tagalogpy
git fetch
git status

if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
    # Send a notification
    notify-send "There are pending commits from the remote repository: tagalogpy"
fi

cd $HOME/repos/bashscripts
git fetch
git status

if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
    # Send a notification
    notify-send "There are pending commits from the remote repository: bashscripts"
fi
