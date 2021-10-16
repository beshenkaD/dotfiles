#!/bin/sh

PACKAGES="bash-completion bspwm neovim emacs dunst firefox ttf-font-awesome"
PACKAGES+="xdotool ttf-hack alacritty ttf-ubuntu-font-family dunst brightnessctl"
PACKAGES+="feh xautolock scrot lightdm lightdm-slick-greeter light-locker"

AUR_PACKAGES="polybar"

sudo pacman -S $PACKAGES
yay -S $AUR_PACKAGES

systemctl enable lightdm
