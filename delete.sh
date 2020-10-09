#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

for folder in $(ls -F | grep /)
do
  echo "installing $folder..."

  if [ "$folder" = "NOSTOW/" ]; then
    cd $folder
    for f in $(ls -F | grep /); do
      cd $f
      echo "deleting $f..."
      sh delete.sh
      cd ..
    done
    cd ..
  else
        stow -D $folder
  fi
done

