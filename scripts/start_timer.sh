#! /bin/bash

# SECONDS should be stored for each session
# 1: 123
# 2: 456
# ...
# When a tmux session is openned, the SECONDS variable is set to the number sat in the storage
# If a new session is created, the SECONDS variable is set to 0 and the storage is updated

if [[ -n "$TMUX_PANE" ]]; then
    # For the moment, this count is taken from a single file -> only one session can be handled
    SECONDS=$(cat /tmp/tmux-timer 2>/dev/null || echo 0)

    base_session_name=$(tmux display -p '#{session_attached}')


    while [[ "$base_session_name" == "$(tmux display -p '#{session_attached}')" ]]; do
        sleep 1
    done

    echo "$SECONDS" > /tmp/tmux-timer
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

# Variable to make available
echo "tmux-timer: $tmux_timer"


