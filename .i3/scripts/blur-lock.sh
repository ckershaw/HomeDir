#!/bin/bash

scrot /tmp/screen_locked.png
mogrify -scale 4% -scale 2500% /tmp/screen_locked.png
i3lock -i /tmp/screen_locked.png
