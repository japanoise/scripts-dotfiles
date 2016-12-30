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

HOST=$(hostname)
case $HOST in
	osiris )
		xrandr --output HDMI-0 --mode 1920x1080 --right-of DVI-0
		setxkbmap -option compose:caps dvorak
		xhost si:localuser:ff
		WM=dwm
		;;
	thoth )
		setxkbmap -layout gb -variant dvorak -option compose:menu -option ctrl:ralt_rctrl
		WM=dwm;;
	*1266 )
		setxkbmap -layout gb -variant dvorak -option compose:menu -option ctrl:ralt_rctrl
		intellij &
		firefox &
		WM=ob
		;;
	*)
		setxkbmap -layout gb -variant dvorak -option compose:menu -option ctrl:ralt_rctrl
		WM=rio
		;;
esac

# This reassigns MS NEK4000 right Menu key to simulate DWM Mod4Key as well.
#xmodmap -e "keycode 135 = Super_L" # reassign MS Menu Keypress to Super_L
#xmodmap -e "remove mod1 = Super_L" # make sure X keeps it out of the mod1 group
xset -dpms
xset s off
xset s noblank
xbindkeys
case $WM in
	ob )
		conky -c ~/.conkyrc-ob
		compton -b
		tint2 &
		dunst &
		openbox-session
		;;
	dwm )
		bg.sh &
		compton -b
		gods &
		dunst &
		exec dwm
		;;
	rio )
		hsetroot -solid '#333333'
		conky -c ~/conkyrc-sa &
		exec rio -term 'PAGER=/bin/cat PATH=$PLAN9/bin:$PATH path=$PATH $PLAN9/bin/9term rc'
		;;
esac
