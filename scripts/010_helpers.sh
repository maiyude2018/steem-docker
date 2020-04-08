#!/usr/bin/env bash
#####################################################################################################
# Steem node manager
# Released under GNU AGPL by Someguy123
#
# Github: https://github.com/Someguy123/steem-docker
#
# This file contains various small functions to avoid cluttering up run.sh
#
#####################################################################################################

rfc_datetime() {
    TZ='UTC' date +'%Y-%m-%dT%H:%M:%S'
}
OS_NAME=$(uname -s)

# date_to_seconds [date_time] 
# for most reliable conversion, pass date/time in ISO format:
#       2020-02-28T20:08:09   (%Y-%m-%dT%H:%M:%S)
# e.g.
#   $ date_to_seconds "2020-02-28T20:08:09"
#   1582920489
#
date_to_seconds() {
    if [[ "$OS_NAME" == "Darwin" ]]; then
        date -j -f "%Y-%m-%dT%H:%M:%S" "$1" "+%s"
    else
        date -d "$1" '+%s'
    fi
}

# compare_dates [rfc_date_1] [rfc_date_2]
# outputs the amount of seconds between date_2 and date_1
#
# e.g.
#   $ compare_dates "2020-03-19T23:08:49" "2020-03-19T20:08:09"
#   10840
# means date_1 is 10,840 seconds in the future compared to date_2
#
compare_dates() {
    echo "$(($(date_to_seconds "$1")-$(date_to_seconds "$2")))"
}

# human_seconds [seconds]
# convert an amount of seconds into a humanized time (minutes, hours, days)
#
# human_seconds 60      # output: 1 minute(s)
# human_seconds 4000    # output: 1 hour(s) and 6 minute(s)
# human_seconds 90500   # output: 1 day(s) + 1 hour(s) + 8 minute(s)
#
human_seconds() {
    local secs="$1" mins hrs days
    local rem_secs rem_mins rem_hrs m

    if (( secs < 60 )); then       # less than 1 minute
        echo "$secs seconds"
    elif (( secs < 3600 )); then   # less than 1 hour
        mins=$(( secs / 60 ))
        rem_secs=$(( secs % 60 ))
        (( rem_secs > 0 )) && echo "$mins minute(s) and $rem_secs second(s)" || echo "$mins minute(s)"
    elif (( secs < 86400 )); then   # less than 1 day
        hrs=$(( secs / 3600 ))
        rem_mins=$(( ( secs % 3600 ) / 60 ))
        (( rem_mins > 0 )) && echo "$hrs hour(s) and $rem_mins minute(s)" || echo "$hrs hour(s)"
    else
        days=$(( secs / 86400 ))
        rem_hrs=$(( ( secs % 86400 ) / 3600 ))
        rem_mins=$(( (( secs % 86400 ) % 3600) / 60 ))
        m="$days day(s)"
        (( rem_hrs > 0 )) && m="${m} + $rem_hrs hour(s)"
        (( rem_mins > 0 )) && m="${m} + $rem_mins minute(s)"
        echo "$m"
    fi
}
