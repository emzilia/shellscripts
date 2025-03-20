#!/usr/bin/env bash
# Runs git status at directory indicated by first argument, just runs 
# git status if not given an argument

if [ -z "$1" ]; then
    git status
    exit 0
fi

dir=$HOME/repos/$1

git -C $dir status
