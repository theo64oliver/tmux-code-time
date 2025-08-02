#!/usr/bin/env bash

seconds_to_readable() {
    local total=$1
    local days=$((total/86400))
    local hours=$(( total/3600 ))
    local mins=$(( (total%3600)/60 ))
    local secs=$((total%60))

    if (( days > 0 )); then
        printf "%dh %dm \n" $hours $mins
    elif (( hours > 0 )); then
        printf "%dh %dm \n" $hours $mins
    elif (( mins > 0 )); then
        printf "%dm \n" $mins
    else
        printf "0m \n"
    fi
}

