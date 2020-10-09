#!/bin/bash

sleep 0.2
scrot -a $(slop -f '%x,%y,%w,%h') -e 'xclip -selection c -t image/png < $f' && rm ~/*_scrot.png
