#!/bin/bash

scrot /tmp/screen_locked.png
convert /tmp/screen_locked.png -scale 4% -sample 1920x1080 /tmp/screen_locked2.png
mv /tmp/screen_locked2.png /tmp/screen_locked.png
i3lock -i /tmp/screen_locked.png
sleep 60; pgrep i3lock && xset dpms force off
