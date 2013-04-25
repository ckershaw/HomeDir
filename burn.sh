#!/bin/bash

control_c()
# run if user hits control-c
{
    killall burnP6
    exit $?
}

trap control_c SIGINT

for i in {1..8}
do
	burnP6 &
	echo "Started burn number $i"
done

while true;do
	cat /sys/class/thermal/thermal_zone0/temp
    sleep 1
done

