#!/bin/bash
#
#this script will display all the command line arguments
#it will also display how many things are on the command line while we do it


##################################
#VARIABLES
#default value for debug is 0
debug=0

####################################
#FUNCTIONS
function displayHelp {
  echo "Usage: $(basename $0) [-h|--help] [-d|--debug N]"
}

######################################
#command line Processing

#This can be used for debugging
#echo "there are $# things on the command line"
while [ $# -gt 0 ] ;do
#work on $1
echo "found '$1' on the command line"
case "$1" in
  -h|--help)
    #found help option
    ;;
  -d|--debug)
    #found debug option
    debug="$2" #TODO:Should validate debug number
    shift
    ;;
  *)
    #bad arguments
    echo "I didn't recognize '$1'" .&2
    displayHelp
    exit 1
    ;;
  esac
  shift
# This can be used for debugging
#echo "There are $# things left to process"
done

echo "Finished processing the command line"
echo "debug variable is set to '$debug'"
