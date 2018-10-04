#!/bin/bash

# This script demonstrates how to trap signals and handle them using functions

#### Variables
programName="$0" # used by error_functions.sh
sleepTime=1 # delay used by sleeptime
numberOfSleeps=10 # how many sleeps to wait for before quitting for inactivity

#### Functions

# This function will send an error message to stderr
# Usage:
#   error-message ["some text to print to stderr"]
#
function error-message {
        local prog=`basename $0`
        echo "${prog}: ${1:-Unknown Error - a moose bit my sister once...}" >&2
}

# This function will send a message to stderr and exit with a failure status
# Usage:
#   error-exit ["some text to print" [exit-status]]
#
function error-exit {
        error-message "$1"
        exit "${2:-1}"
}
function usage {
        cat <<EOF
Usage: ${programName} [-h|--help ] [-w|--waittime waittime] [-n|--waitcount waitcount]
Default waittime is 1, waitcount is 10
EOF
}

# Normally traps catch signals and do something useful or necessary with them

# Quit if we get SIGQUIT, but let the user know why we are exiting
function receivedQuit {
    echo "Received SIGQUIT"
    exit
}

# Squawk if we get SIGHUP
function receivedHup {
    echo "Received SIGHUP"
}

# If we get SIGINT, we reset the counter
function receivedInt {
    echo "Received SIGINT, resetting sleep count"
    sleepCount=$numberOfSleeps
}

# trap the signals we care about
trap receivedQuit SIGQUIT
trap receivedHup SIGHUP
trap receivedInt SIGINT

#### Main Program

# Process command line parameters
while [ $# -gt 0 ]; do
    case $1 in
        -w | --waittime )
            shift
            sleepTime="$1"
            ;;
        -n | --waitcount)
            shift
            numberOfSleeps="$1"
            ;;
        -h | --help )
            usage
            exit
            ;;
        * )
            usage
            error-exit "$1 not a recognized option"
    esac
    shift
done

if [ ! $numberOfSleeps -gt 0 ]; then
    error-exit "$numberOfSleeps is not a valid count of sleeps to wait for signals"
fi

if [ ! $sleepTime -gt 0 ]; then
    error-exit "$sleepTime is not a valid time to sleep while waiting for signals"
fi

sleepCount=$numberOfSleeps

while [ $sleepCount -gt 0 ]; do
    echo "Waiting $sleepCount more times for signals"
    sleep $sleepTime
    sleepCount=$((sleepCount - 1))
done
echo "Wait counter expired, exiting peacefully"
