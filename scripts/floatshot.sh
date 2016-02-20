#!/bin/bash

PIC=`date "+/tmp/%Y-%m-%d_%H:%M:%S.png"`

scrot -s $PIC

feh --title feh:$PIC $PIC &
sleep 0.1
i3-msg \[title=feh:"$PIC"\] floating enable
i3-msg \[title=feh:"$PIC"\] border normal
