#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "deleting st configs..."
rm /etc/portage/savedconfig/x11-terms/st
rm -r /etc/portage/patches/x11-terms/st
