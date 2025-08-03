#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
storage_dir="${CURRENT_DIR%/scripts*}/"
storage_file="$storage_dir"tmux-timer.txt

if [ $# -eq 0 ]; then
  # Delete the whole file to reset all timers.
  echo "" > $storage_file
  session_name=$(tmux display -p '#{session_name}')
  sed -i "s/^$session_name=.*/$session_name=0/" "$storage_file"
else
  # Delete only the sessions specified as arguments.
  for i in "$@"
  do
    echo deleting $i in $storage_file
    sed -i "/^$i=/d" $storage_file
  done
fi
