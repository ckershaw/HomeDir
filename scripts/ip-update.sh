#!/bin/bash

HOOK_URL="https://umbrella.eecs.umich.edu:8000/hooks/rskicd9d6tftjktci4gmxiztsr"

mkdir -p $HOME/.cache
cache_file=$HOME/.cache/ip-update

touch $cache_file

old_ip=`cat $cache_file`

new_ip=`ip addr show eth0 | \grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`

if [[ $old_ip != $new_ip ]] ; then
    echo "New IP! $old_ip"

    res=`curl -i -X POST -d 'payload={"channel" : "@mattermostbot", "text": "New IP: '$new_ip'"}' $HOOK_URL`

    echo $new_ip > $cache_file

else

    echo "Same IP as before $old_ip"
fi
