#! /bin/bash

SECONDS=0


# Exec code here
# SECONDS should be stored for each session
# 1: 123
# 2: 456
# ...
# When a tmux session is openned, the SECONDS variable is set to the number sat in the storage
# If a new session is created, the SECONDS variable is set to 0 and the storage is updated
# Or (this one might be even better because it seems to not depend on the version of tmux)

if [[ -n "$TMUX_PANE" ]]; then
    tmux display -p '#{session_name}'
    sleep 61
fi

let "hours=(SECONDS/3600)%24"
let "minutes=(SECONDS%3600)/60"
let "seconds=(SECONDS%3600)%60"

# This code should be called at all time (to display it in the tmux status bar)
if (( $SECONDS > 3600 )) ; then
    tmux_timer="${hours}h ${minutes}m ${seconds}s"
elif (( $SECONDS > 60 )) ; then
    tmux_timer="${minutes}m ${seconds}s"
else
    tmux_timer="${SECONDS}s"
fi

echo "tmux-timer: $tmux_timer"
