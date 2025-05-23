#!/usr/bin/env bash

run_script_when_openning_session()
{
  tmux set-hook -g client-session-changed "run-shell '$HOME/Desktop/pers/tmux-code-time/scripts/start_timer.sh'"
  tmux set-hook -g session-created "run-shell '$HOME/Desktop/pers/tmux-code-time/scripts/start_timer.sh'"

}


main()
{
  run_script_when_openning_session
}

main
