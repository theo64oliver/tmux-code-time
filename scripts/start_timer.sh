SECONDS=0


# Exec code here
# SECONDS should be stored for each session
# 1: 123
# 2: 456
# ...
# When a tmux session is openned, the SECONDS variable is set to the number sat in the storage
# If a new session is created, the SECONDS variable is set to 0 and the storage is updated

# This code should be called at all time (to display it in the tmux status bar)
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
