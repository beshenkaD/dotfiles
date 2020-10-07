#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

for folder in $(ls -F | grep /)
do
  echo "installing $folder..."

  if [ "$(ls $folder)" = "etc" ] 
  then
	stow -t / $folder
  else
  	stow $folder
  fi
done
