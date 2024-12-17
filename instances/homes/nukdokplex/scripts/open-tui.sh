#!/usr/bin/env sh

tool=$1
loc=$2

loc=${loc#"file://"}

if [[ ! -e $loc ]]; then
	loc=$(dirname "$loc")
fi

hyprctl dispatch exec "alacritty -- '$tool' '$loc'"
