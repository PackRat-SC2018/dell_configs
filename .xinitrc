#!/bin/sh
# this file is executed when calling startx
#
# system wide defaults

sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# user init scripts and settings
[ -r ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -r ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -r ~/.Xprofile ] && . ~/.Xprofile

# Window manager for X session
# to start a different WM, set session="WM" below, or in console run:
# startx ~/.xinitrc WM

# session to run if none passed as first arg ($1)
session="${1:-i3}"

# set environment wm for use in scripts
export WM="$session"

# do NOT put commands below the exec lines
case $session in
    i3)         exec dbus-run-session i3 ;;
    fluxbox)    exec dbus-run-session startfluxbox ;;
    dk)         exec dbus-run-session dk ;;
    fvwm3)      exec dbus-run-session fvwm3 ;;
    dwm)        exec dbus-run-session dwm ;;
    *)          exec "$session" # Unknown, try running it
esac

exit 0 ;
