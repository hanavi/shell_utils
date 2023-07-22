#!/bin/bash
# Author: James Casey
# Last Updated: 2023-07-22

## This file should be sourced

# Find a logs folder in a parent path and open the most recently modified .log
# file with tail -f
function llog {

    cdir=$(pwd)

    # Step up until we find a logs directory
    while true; do

        logdir="${cdir}/logs"
        if [ -d "${logdir}" ]; then
            break;
        fi

        # if we get to the top, then give up!
        if [ "${cdir}" = "/" ]; then
            printf "no logdir found!\n"
            return;
        fi
        cdir=$(dirname "${cdir}")
    done

    printf "\n-------------------------------------------\n"
    pushd "${logdir}" >/dev/null
    printf "$(pwd)\n"

    # Search for the newest ".log" file
    logfile=$( find . -type f -print0 -name "*.log" \
        | xargs -0 stat --format '%Y :%n' \
        | sort -nr \
        | cut -d: -f2- \
        | head -n 1
    )

    if [ ! -f "${logfile}" ]; then
        printf "No log file found!\n"
        return
    fi

    printf "logfile: ${logfile}\n"
    printf "-------------------------------------------\n\n"

    tail -f "${logfile}"
}
