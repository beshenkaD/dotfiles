#!/bin/sh

packages="bash-completion
"

sudo pacman -Syu
sudo pacman -S $packages
