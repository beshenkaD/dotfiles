#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "deleting dwmblocks configs..."
rm /etc/portage/savedconfig/x11-misc/dwmblocks
rm -r /etc/portage/patches/x11-misc/dwmblocks
