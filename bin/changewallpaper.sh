#!/bin/sh

while true; do
    hsetroot -fill ~/Pictures/wallpapers/$(ls Pictures/wallpapers | shuf -n 1)

    if [ "$1" = "d" ]; then
        notify-send "Wallpaper has changed"
        sleep 10800
    else
        notify-send "Wallpaper has changed"
        exit
    fi
done
