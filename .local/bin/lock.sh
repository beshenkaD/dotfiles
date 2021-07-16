#!/bin/sh

check_fullscreen() {
    for s in pseudo_tiled tiled floating fullscreen; do
        bspc query -N -n "${1:-focused}.${s}" >/dev/null && { printf "$s"; }
    done
}

if [ "$(check_fullscreen)" != "fullscreen" ]; then
    ~/.local/bin/i3lock-fancy
else
    exit
fi
