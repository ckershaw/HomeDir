#!/bin/bash
if [ $# -eq "0" ] ; then
    echo "Sleeping now"
    systemctl suspend
else
    echo "Sleeping in $1 minutes"


    let "s = $1*60"

    sleep $s

    sleep 10 && systemctl suspend &

    i3-nagbar -m "sleeping soon" -b 'Cancel It' 'pkill sleep.sh '

fi
