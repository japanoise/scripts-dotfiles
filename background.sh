#!/bin/sh
#For Konata and Kanaria
DIR='/home/chameleon/backgrounds/twoscreens'
while true
do
	hsetroot -center "$(shuf -en1 "$DIR"/*)"
	sleep 30m
done
