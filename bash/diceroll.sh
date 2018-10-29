#!/bin/bash
# this script will roll virtual dice and show what was rolled and what the total rolled was

#############
# VARIABLES #
#############
#default value for for count is 2
count=2
#default value for for sides is 6
sides=6

sum=0

#############
# Functions #
#############
#displays help options for user input
function displayHelp {
  echo "Usage: $(basename $0) [-h|--help] [-c|--count N] [-s|--sides N]"
}
########
# MAIN #
########
# Process command line parameters
while [ $count -gt 0 ]; do
  case "$1" in
  -h|--help)
  #displays help options from function displayHelp
        displayHelp
        exit 0
        ;;
  -c|--count)
  #set count variable of dice to roll to an input between 1-9
        if [[ "$2" =~ ^[1-9]$ ]]; then
            count="$2"
            shift
        else
              #if input not between 1-9 directs error output to stderr
              echo "Cannot set count without a number of dice from 1 to 9"  >&2
              exit 2 #exits with error message
        fi
        ;;
  -s| --sides)
  #sets sides variable of dice to an input between 4-20
        if (( "$2" >= 4 && "$2" <= 20 )); then
            sides="$2"
            shift
        else
              #if user input not between 4-20 directs error output to stderr
              echo "$2 is an invalid number, cannot set dice sides without a number of sides from 4 to 20"  >&2
              exit 2 #exits with error message
        fi
        ;;
  *)
  esac
  shift

roll=$(( $RANDOM % $sides +1 ))
sum=$(( $sum + $roll ))
echo "Rolled $roll"
count=$((count - 1))
done
echo "You rolled a total of $sum"
