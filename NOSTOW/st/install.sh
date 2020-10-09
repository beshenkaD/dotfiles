#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

configDir="/etc/portage/savedconfig/x11-terms"
patchDir="/etc/portage/patches/x11-terms/st"

if [ -e "$configDir/st" ]; then
  echo "removing old config..."
  rm $configDir/st
fi

if [ -d "$patchDir" ]; then
  echo "removing old patches..."
  rm -r $patchDir
fi

mkdir -p $configDir/
mkdir -p $patchDir/

echo "installing config..."
cp $(pwd)/config/st $configDir/

echo "installing patches..."
cp $(pwd)/patches/* $patchDir/

emerge st
