#!/bin/bash
for i in {1..8}
do
	burnP6 &
	echo "Started burn number $i"
done
echo "to end enter killall burnP6"
while true;do
	cat /sys/class/thermal/thermal_zone0/temp
done
