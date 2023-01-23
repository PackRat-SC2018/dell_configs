#!/bin/sh

# kill polybar
#killall -q polybar &

if hash polybar >/dev/null 2>&1; then
	pkill polybar
fi

# (re)load conky
if hash conky >/dev/null 2>&1; then
	pkill conky
	conky -p 3 -d -c $HOME/conky/conkytaorc &
fi
