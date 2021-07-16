#!/bin/bash

ping gentoo.org -c 1 -W 3 &> /dev/null || exit

EMERGE_MULTI="--jobs=6 --load-average=8"

read -p "Do you want to sync the portage tree? " yn
case $yn in
    [Yy]* ) eix-sync;;
    [Nn]* ) ;;
    * ) echo "Please answer yes or no.";;
esac

emerge -uvDN --complete-graph=y --with-bdeps=y @world $EMERGE_MULTI ||
emerge -uvDN --complete-graph=y --with-bdeps=y @world || exit

emerge @preserved-rebuild $EMERGE_MULTI ||
emerge @preserved-rebuild || exit

echo -1 | etc-update

revdep-rebuild -i -- $EMERGE_MULTI ||
revdep-rebuild || exit

emerge -c $EMERGE_MULTI

echo "** FINISHED"
