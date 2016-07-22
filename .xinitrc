#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f "$sysresources" ]; then
    xrdb -merge "$sysresources"
fi

if [ -f "$sysmodmap" ]; then
    xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setxkbmap -option caps:none gb
# This reassigns MS NEK4000 right Menu key to simulate DWM Mod4Key as well.
xmodmap -e "keycode 135 = Super_L" # reassign MS Menu Keypress to Super_L
xmodmap -e "remove mod1 = Super_L" # make sure X keeps it out of the mod1 group
xset -dpms
xset s off
xhost si:localuser:ff
background.sh &
compton -b
xbindkeys
urxvtd -q -o -f
dunst &
#lxpanel --profile LXDE &
(conky | while read LINE; do xsetroot -name "$LINE"; done) &
exec dwm
