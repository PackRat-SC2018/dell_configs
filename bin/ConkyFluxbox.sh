#!/bin/sh

# kill polybar
killall -q polybar &

# (re)load conky
if hash conky >/dev/null 2>&1; then
	pkill conky
	conky -p 1 -d -c $HOME/conky/conkyfluxboxrc &
	conky -p 2 -d -c $HOME/conky/conkytaorc &
fi