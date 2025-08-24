# tmux-code-time

Tmux code time is a tmux pluggin that monitor the time spent on each tmux session. This comes particularly handy when billing clients.
The time recorded persists between reboot and all actions, to reset the count, please use the following script outside a tmux session: `reset_count.sh`

## IMPORTANT NOTICE
The pluggin is at it's early life, having multiple terminals running tmux at the same time doesn't work. It creates an undefined behaviour.
This will be fixed in an upcomming release. To enjoy the pluggin at its best, please run tmux in only one terminal and navigate trough tmux (cleanest way to use tmux).

## Installation:

### Manual installation
Clone the repo:
```$ git clone https://github.com/theo64oliver/tmux-code-time ~/.tmux/plugins/tmux-code-time```
Add the following line to your `.tmux.conf`: 
```run-shell ~/.tmux/plugins/tmux-code-time/code-time.tmux```
Reload the tmux environment: 
```$ tmux source-file ~/.tmux.conf```

## Integration in your tmux status bar:
You can add the time spent in current session adding the following command to your `.tmux.conf` file:
- `set -g status-right #{project_time}` to display it as the leftmost item in the right part of your status bar.
- `set -g status-left #{project_time}` to display it as the leftmost item in the left part of your status bar.

### Note for catppuccin users:
An integration to catpuccin is currently under review, in the meantime, please follow the next steps to have the catpuccin themes:
- Put the following lines in you `.tmux.conf`: 
<details>
<summary>🌻 Latte</summary>

```
set -g @catppuccin_status_project_time "#{@project_time}"
set -g status-right "#[bg=#c6a0f6,fg=#181926]#[reverse]#[noreverse]⏲ "
set -ag status-right "#[fg=#4c4f69,bg=#eff1f5] #{E:@catppuccin_status_project}"
```

</details>

<details>
<summary>🪴 Frappé</summary>


```
set -g @catppuccin_status_project_time "#{@project_time}"
set -g status-right "#[bg=#c6a0f6,fg=#181926]#[reverse]#[noreverse]⏲ "
set -ag status-right "#[fg=#c6d0f5,bg=#303446] #{E:@catppuccin_status_project}"
```

</details>

<details>
<summary>🌺 Macchiato</summary>

```
set -g @catppuccin_status_project_time "#{@project_time}"
set -g status-right "#[bg=#c6a0f6,fg=#181926]#[reverse]#[noreverse]⏲ "
set -ag status-right "#[fg=#cad3f5,bg=#24273a] #{E:@catppuccin_status_project}"
```

</details>

<details>
<summary>🌿 Mocha</summary>

```
set -g @catppuccin_status_project_time "#{@project_time}"
set -g status-right "#[bg=#c6a0f6,fg=#181926]#[reverse]#[noreverse]⏲ "
set -ag status-right "#[fg=#cdd6f4,bg=#1e1e2e] #{E:@catppuccin_status_project}"
```

</details>

