#!/usr/bin/env bash

path="$0"
CURRENT_DIR="${path%/scripts/*}/"
storage_file="$CURRENT_DIR"tmux-timer.txt
LOG_FILE="$CURRENT_DIR"tmux-code-time-debug.log

# Get the seconds_to_readable function
source "$CURRENT_DIR/scripts/utilities.sh"

session_name=$(tmux display -p '#{session_name}')
seconds_to_readable $(sed -n "s/^$session_name=\(.*\)/\1/p" "$storage_file")
