# scripts-dotfiles
Blantantly copying ScoreUnder and **UNIX TRENDY HIPSTERS**

Most files are copyright (C) 2016 japanoise, licensed under the MIT license. I'd 
appreciate a heads up if you use them, but it's not mandatory. .xinitrc is currently
licensed under the GNU GPLv2 license. I plan to rewrite it or base it on the Gentoo
version soon, however.

## The dotfiles/configs
### compton.conf
Just a generic nice config I stole from somewhere.

### .conkyrc
Bar with network, cpu and memory bar, cmus-np, timestamp

### DarkMonokai.qss
Slightly modified from original author, nice dark theme for Quassel.

### dillorc
Colours, keybindings.

### dwm-6.1.h
Theming, binding for fibonacci, etc.

### i3config
ScoreUnder's with some personal preference modifications; less keybindings 
(they're done with xbindkeys instead for easy migration between wms)

### rkj-chameleon.zsh-theme
My old oh-my-zsh theme; no longer maintained, use my .zshrc instead.

### .xbindkeysrc
Bindings used with dwm.

### .xbindkeysrc-i3
Bindings used with i3.

### .Xresources
Theming (now custom), settings for urxvt.

### .zshrc
Imitates oh-my-zsh with custom theme, but with less bloat. Nice fancy prompt 
with git. 

The new theme is unnamed. It's loosely based on Score_Under's, having the user,
machine, and current working directory, but I've applied truncation and added
hieroglyphs for home machine hostnames.

Loads from .zshrc-local for machine specific commands.

## The scripts
### background.sh
Background switcher using hsetroot.

### cdump.sh
Clone of a script seen in a screenshot; displays colors and guesses their 
values from .Xresources.

### cmus-np
If cmus is running, show a play or stop icon, artist, song, percentage 
completed. Else "No music."

### doom
Launcher for doom/sourceports. `doom [z]n [args]`

### info.sh
Z3bra's info.sh from their ricing guide, ported to Gentoo.

### screenshot.sh
Crappy screenshot script; takes screenshot, runs optipng, puts it somewhere 
sensible with a sensible name.
