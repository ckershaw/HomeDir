#!/bin/bash

xautolock -time 3 -locker ~/.i3/scripts/blur-lock.sh -killtime 10 -killer ~/scripts/screenOff.sh -notify 30 -notifier "notify-send LOCKING SOON!" &

