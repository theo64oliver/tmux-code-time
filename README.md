# tmux-code-time


## IMPORTANT:
Add the following line to your `.tmux.conf` to make the pluggin active: `run-shell ~/Desktop/pers/tmux-code-time/code-time.tmux`


## Features

- The purpose of this plugin is to show how long you worked on a project
- This could be useful to invoice a client

- Add a command to stop the timer for a session and restart it (maybe auto restart it)
-> This is usefull when locking your laptop and you don't want to track time
-> don't know technically how to do it

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

## Check if the laptop is locked (need to dive into this)
```
#!/bin/bash

while read line 
do
    case "$line" in
        *"{'LockedHint': <true>}"*) ./session_logger.sh true;;
        *"{'LockedHint': <false>}"*) ./session_logger.sh false;;
    esac
done < <(gdbus monitor -y -d org.freedesktop.login1)

```

## Check on https://github.com/tmux-plugins/tmux-battery to understand how to init something that can be displayed in the status bar

## How to create a tmux plugin
https://github.com/tmux-plugins/tpm/blob/master/docs/how_to_create_plugin.md
https://github.com/tmux-plugins/tmux-example-plugin ++++++++++

## Note for catppuccin users:

An integration to catpuccin is currently under review, in the meantime, please follow the next steps:
- Put the following lines in you `.tmux.conf`: 
<details>
<summary>🌻 Latte</summary>

```set -g @catppuccin_status_project "#(/home/theo/Desktop/pers/tmux-code-time/scripts/project_time.sh)"
set -g status-right "#[bg=#c6a0f6,fg=#181926]#[reverse]#[noreverse]⏲ "
set -ag status-right "#[fg=#4c4f69,bg=#eff1f5] #{E:@catppuccin_status_project}"```

</details>

<details>
<summary>🪴 Frappé</summary>


```set -g @catppuccin_status_project "#(/home/theo/Desktop/pers/tmux-code-time/scripts/project_time.sh)"
set -g status-right "#[bg=#c6a0f6,fg=#181926]#[reverse]#[noreverse]⏲ "
set -ag status-right "#[fg=#c6d0f5,bg=#303446] #{E:@catppuccin_status_project}"```

</details>

<details>
<summary>🌺 Macchiato</summary>

```set -g @catppuccin_status_project "#(/home/theo/Desktop/pers/tmux-code-time/scripts/project_time.sh)"
set -g status-right "#[bg=#c6a0f6,fg=#181926]#[reverse]#[noreverse]⏲ "
set -ag status-right "#[fg=#cad3f5,bg=#24273a] #{E:@catppuccin_status_project}"```

</details>

<details>
<summary>🌿 Mocha</summary>

```set -g @catppuccin_status_project "#(/home/theo/Desktop/pers/tmux-code-time/scripts/project_time.sh)"
set -g status-right "#[bg=#c6a0f6,fg=#181926]#[reverse]#[noreverse]⏲ "
set -ag status-right "#[fg=#cdd6f4,bg=#1e1e2e] #{E:@catppuccin_status_project}"```

</details>

