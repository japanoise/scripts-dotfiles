#!/bin/sh
filename="$(date +'%F-%T')-screenshot.png"
ssdir="/home/chameleon/media/pics/screenshots"
scrot "$ssdir/$filename"
optipng "$ssdir/$filename"
