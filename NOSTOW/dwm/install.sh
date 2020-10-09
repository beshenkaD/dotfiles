#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

configDir="/etc/portage/savedconfig/x11-wm"
patchDir="/etc/portage/patches/x11-wm/dwm"

if [ -e "$configDir/dwm" ]; then
  echo "removing old config..."
  rm $configDir/dwm
fi

if [ -d "$patchDir" ]; then
  echo "removing old patches..."
  rm -r $patchDir
fi

mkdir -p $configDir/
mkdir -p $patchDir/

echo "installing config..."
cp $(pwd)/config/dwm $configDir/

echo "installing patches..."
cp $(pwd)/patches/* $patchDir/

emerge dwm
