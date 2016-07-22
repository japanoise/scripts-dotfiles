#!/bin/sh
filename="$(date +'%F-%T')-screenshot.png"
ssdir="/home/chameleon/pics/screenshots"
scrot "$ssdir/$filename"
optipng "$ssdir/$filename"
