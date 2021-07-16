#!/bin/sh

while true; do
    theme=$(cat ~/.config/xsettingsd/xsettingsd.conf)
    if echo "$theme" | grep 'dark'; then
        pic=$(ls Pictures/wallpapers/*dark* | shuf -n 1)
    else
        pic=$(ls Pictures/wallpapers/*light* | shuf -n 1)
    fi

    hsetroot -center $pic

    if [ "$1" = "d" ]; then
        notify-send "Wallpaper has changed"
        sleep 10800
    else
        notify-send "Wallpaper has changed"
        exit
    fi
done
