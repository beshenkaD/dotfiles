#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

for folder in $(ls -F | grep /)
do
  echo "deleting $folder..."

  if [ "$(ls $folder)" = "etc" ]
  then
        stow -D -t / $folder
  else
        stow -D $folder
  fi

done
