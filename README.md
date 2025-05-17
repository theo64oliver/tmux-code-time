# tmux-code-time

## Usefull commands
```

for s in $(tmux list-sessions -F '#{session_name}'); do
    tmux list-panes -F '#{pane_tty} #{session_name}' -t "$s"
done | grep "$(tty)" | awk '{print $2}'

# This works probably better
if [[ -n "$TMUX_PANE" ]]; then
    tmux list-panes -t "$TMUX_PANE" -F '#S' | head -n1
fi

# Or (this one might be even better because it seems to not depend on the version of tmux)
if [[ -n "$TMUX_PANE" ]]; then
    tmux display -p '#{session_name}'
fi
```

Create a timer:
```
SECONDS=0

if (( $SECONDS > 3600 )) ; then
    let "hours=SECONDS/3600"
    let "minutes=(SECONDS%3600)/60"
    let "seconds=(SECONDS%3600)%60"
    echo "Completed in $hours hour(s), $minutes minute(s) and $seconds second(s)" 
elif (( $SECONDS > 60 )) ; then
    let "minutes=(SECONDS%3600)/60"
    let "seconds=(SECONDS%3600)%60"
    echo "Completed in $minutes minute(s) and $seconds second(s)"
else
    echo "Completed in $SECONDS seconds"
fi

```

How to create a tmux plugin
https://github.com/tmux-plugins/tpm/blob/master/docs/how_to_create_plugin.md
https://github.com/tmux-plugins/tmux-example-plugin ++++++++++


Check on https://github.com/tmux-plugins/tmux-battery to understand how to init something that can be displayed in the status bar
