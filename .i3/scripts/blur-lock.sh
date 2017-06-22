#!/bin/bash

scrot /tmp/screen_locked.png
convert /tmp/screen_locked.png -scale 1% -scale 10000% /tmp/screen_locked2.png
mv /tmp/screen_locked2.png /tmp/screen_locked.png
i3lock -i /tmp/screen_locked.png
sleep 60; pgrep i3lock && xset dpms force off
