#!/bin/bash
if [ $# -eq "0" ] ; then
    sudo echo "Sleeping now"
    sudo pm-suspend
else
    sudo echo "Sleeping in $1 minutes"

    let "s = $1*60"

    sudo sleep $s &&  amixer sset Master mute && sudo pm-suspend
fi
