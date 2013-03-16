#!/bin/bash
for i in {0..7}
do
	sudo cpufreq-set -c $i -g userspace
	sudo cpufreq-set -c $i -f 2.40GHz
done
