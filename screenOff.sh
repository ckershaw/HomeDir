#!/bin/bash
if [ $# -gt "0" ]; then
    sudo ~/scripts/sleep.sh $1 &
fi

sleep 1 && xset dpms force off;


