#! /bin/bash

storage_file="$HOME/.tmux/tmux-timer.txt"

# Make sure the storage file exists
# touch "$storage_file"

if [[ -n "$TMUX_PANE" ]]; then
    is_session_visible=$(tmux display -p '#{session_attached}')

    session_name=$(tmux display -p '#{session_name}')
    SECONDS=$(grep "^$session_name=" "$storage_file" | cut -d'=' -f2)

    if [[ -z "$SECONDS" ]]; then
      SECONDS=0
    fi

    # This while loop is used to check if the session has changed
    while [[ "$is_session_visible" == "$(tmux display -p '#{session_attached}')" ]]; do
        sleep 1
    done

    # Store the session name and the time in the storage file
    if grep -q "^$session_name=" "$storage_file"; then
      sed -i "s/^$session_name=.*/$session_name=$SECONDS/" "$storage_file"
    else
      echo "$session_name=$SECONDS" >> "$storage_file"
    fi

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


