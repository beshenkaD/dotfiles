#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "deleting dwm configs..."
rm /etc/portage/savedconfig/x11-wm/dwm
rm -r /etc/portage/patches/x11-wm/dwm
