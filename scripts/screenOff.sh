#!/bin/bash

$linenum

if [ $# -gt "0" ]; then
    LINENUM=$1
else
    LINENUM=0
fi

sleep 1 && xset dpms force off;


