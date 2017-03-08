# scripts-dotfiles

**This repo is unmaintained and full of legacy crap.**
[Please go to my new dotfiles repo unless you're interested in
history.](https://github.com/japanoise/neo-dotfiles)

Blantantly copying ScoreUnder and **UNIX TRENDY HIPSTERS**

Most files are copyright (C) 2016 japanoise, licensed under the MIT license. I'd
appreciate a heads up if you use them, but it's not mandatory. Copyrights for
files not written by me are noted in the list.

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

I now use [the pure theme for zsh.](https://github.com/sindresorhus/pure) So
make sure you have it installed before using this file.

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

### imgur
[Copyright Phillip Tang.](https://github.com/tangphillip/Imgur-Uploader) I
only slightly modified it to use https instead of http for output links.

### info.sh
Z3bra's info.sh from their ricing guide, ported to Gentoo.

### screenshot.sh
Crappy screenshot script; takes screenshot, runs optipng, puts it somewhere
sensible with a sensible name.
