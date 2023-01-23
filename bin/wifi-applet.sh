#!/bin/sh
# (re)load sxhkd for keybinds
if hash nm-applet >/dev/null 2>&1; then
	pkill nm-applet
	nm-applet &
fi