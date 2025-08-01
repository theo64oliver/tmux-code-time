#!/usr/bin/env bash

seconds_to_readable() {
    local total=$1
    local days=$((total/86400))
    local hours=$(( (total%86400)/3600 ))
    local mins=$(( (total%3600)/60 ))
    local secs=$((total%60))

    if (( days > 0 )); then
        printf "%dd %dh %dm %ds\n" $days $hours $mins $secs
    elif (( hours > 0 )); then
        printf "%dh %dm %ds\n" $hours $mins $secs
    elif (( mins > 0 )); then
        printf "%dm %ds\n" $mins $secs
    else
        printf "%ds\n" $secs
    fi
}

path="$0"

LOG_FILE="${path%/scripts/*}/tmux-code-time-debug.log"

storage_file="${path%/scripts/*}/tmux-timer.txt"
# Make sure the storage file exists
touch "$storage_file"

if [[ -n "$TMUX" ]]; then

    echo "[$(date)] STARTING TIMER for session $(tmux display-message -p '#S')" >> "$LOG_FILE"

    visible_session_name=$(tmux display-message -p '#S')

    session_name=$(tmux display -p '#{session_name}')
    INITIAL_SECONDS=$(grep "^$session_name=" "$storage_file" | cut -d'=' -f2)
    SECONDS="$INITIAL_SECONDS"

    if [[ -z "$SECONDS" ]]; then
      SECONDS=0
    fi

    # This while loop is used to check if the session has changed
    while [[ "$visible_session_name" == "$(tmux display-message -p '#S')" ]]; do
        # TODO: Find the best way to update the file every seconds without it being too heavy.
        # We only update the file when we switch session for the moment
        sleep 1

        # Store the session name and the time in the storage file
        if grep -q "^$session_name=" "$storage_file"; then
          sed -i "s/^$session_name=.*/$session_name=$SECONDS/" "$storage_file"
        else
          echo "$session_name=$SECONDS" >> "$storage_file"
fi
    done

    on_display="$(seconds_to_readable $((SECONDS-INITIAL_SECONDS)))"
    echo "[$(date)] STOPPING TIMER for session $session_name, was on display for $on_display" >> "$LOG_FILE"
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
