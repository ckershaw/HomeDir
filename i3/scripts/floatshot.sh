#!/bin/bash

PIC="/tmp/$RANDOM.png"

scrot -s $PIC

feh --title feh:$PIC $PIC &
sleep 0.1
i3-msg \[title=feh:"$PIC"\] floating enable
