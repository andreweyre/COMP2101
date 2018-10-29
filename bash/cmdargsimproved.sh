#!/bin/bash
#
# this script display all the command line args
# it will also display how many things are on the command line while we do it

###########
# Variables
# default value for debug is 0
declare -i debug
debug=0

###########
# Functions
function displayHelp {
  echo "Usage: $(basename $0) [-h|--help] [-d|--debug N]"
}

######################
# Command line processing

# This can be used for debugging
# echo "There are $# things on the command line"
while [ $# -gt 0 ]; do
# work on $1
case "$1" in
  -h|--help)
    # found help option
    displayHelp
    ;;
  -d|--debug)
    # found debug option
    debug="$2" # TODO: should validate debug number
    shift
    ;;
  *)
    # bad args
    echo "I didn't recognize '$1'" >&2
    displayHelp
    exit 1
    ;;
esac
shift
# This can be used for debugging
# echo "There are $# things left to process"
done
# This can be used for debugging
# echo "Finished processing the command line"

##############
# Main script
echo "debug variable is set to '$debug'"
