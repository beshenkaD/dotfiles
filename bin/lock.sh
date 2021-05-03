#!/bin/sh

check_fullscreen() {
    for s in pseudo_tiled tiled floating fullscreen; do
        bspc query -N -n "${1:-focused}.${s}" >/dev/null && { printf "$s"; }
    done
}

if [ "$(check_fullscreen)" != "fullscreen" ]; then
    i3lock -i $HOME/Pictures/wallpapers/lock.png
else
    exit
fi
