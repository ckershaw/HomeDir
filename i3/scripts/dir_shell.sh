#!/bin/bash
args=("$@")

ID=$(xdpyinfo | grep focus | cut -f4 -d " " | sed s/,//)
FPID=$(xprop -id $ID | grep -m 1 PID | cut -d " " -f 3)
DEF_SHELL=${SHELL##*/}
PID=$(pgrep -P $FPID -l -x $DEF_SHELL|cut -d ' ' -f 1)
TERM_PATH=$(readlink /proc/$PID/cwd)

if [ $args[1]=='--debug' ]
then
  echo -e "id: $ID" > ~/term_path_debug
  echo -e "FPID: $FPID" >> ~/term_path_debug
  echo -e "DEF_SHELL: $DEF_SHELL" >> ~/term_path_debug
  echo -e "PID: $PID" >> ~/term_path_debug
  echo -e "TERM_PATH: $TERM_PATH" >> ~/term_path_debug
fi

if [ -z "$TERM_PATH"  ]
then
  x-terminal-emulator &
else
  x-terminal-emulator -cd $TERM_PATH &
fi
