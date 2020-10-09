#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

configDir="/etc/portage/savedconfig/x11-misc"
patchDir="/etc/portage/patches/x11-misc/dwmblocks"

if [ -e "$configDir/dwmblocks" ]; then
  echo "removing old config..."
  rm $configDir/dwmblocks
fi

if [ -d "$patchDir" ]; then
  echo "removing old patches..."
  rm -r $patchDir
fi

mkdir -p $configDir/
mkdir -p $patchDir/

echo "installing config..."
cp $(pwd)/config/dwmblocks $configDir/

echo "installing patches..."
cp $(pwd)/patches/* $patchDir/

emerge dwmblocks
