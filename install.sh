#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

for folder in $(ls -F | grep /)
do
  echo "installing $folder..."

  if [ "$folder" = "NOSTOW/" && "$folder" = "PICTURES/" ]; then
    cd $folder
    for f in $(ls -F | grep /); do
      cd $f
      echo "installing $f..."
      sh install.sh
      cd ..
    done
    cd ..
  else
  	stow $folder
  fi
done

if [ -e "/etc/profile.d/localpath" ]; then
  mkdir /etc/profile.d
  touch /etc/profile.d/localpath
  echo export PATH="$PATH:/home/$USER/.local/bin" > /etc/profile.d/localpath
  echo export PATH="$PATH:/home/$USER/.local/bin/statusbar" > /etc/profile.d/localpath
fi
