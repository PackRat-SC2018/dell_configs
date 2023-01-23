#!/bin/sh

# (re)load polybar
if hash polybar >/dev/null 2>&1; then
	killall -q polybar
	polybar fluxbox-bar &
fi

# (re)load conky
if hash conky >/dev/null 2>&1; then
	killall -q conky
	conky -p 3 -d -c $HOME/conky/conkytaorc &
fi