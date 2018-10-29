#!/bin/bash
#
# This script implements a guessing game
# it will pick a secret number from 1 to 10
# it will then repeatedly ask the user to guess the number
#    until the user gets it right

cat <<EOF
Let's play a game.
I will pick a secret number from 1 to 10 and you have to guess it.
If you get it right, you get a virtual prize.
Here we go!

EOF

secretnumber=$(($RANDOM % 10 +1)) # save our secret number to compare later

while [ "$userguess" != "$secretnumber" ]; do # loop around until they get it right
  read -p "Give me a number from 1 to 10: " userguess # ask for a guess
# ignore empty guesses
  [ -n "$userguess" ] || continue
# guess must have a number only
# ***** Debian bash requires no quotes around regex, others require them! *****
  [[ $userguess =~ ^[1-9]0*$ ]] || continue
# number has to be 1 or more
  [ $userguess -ge 1 ] || continue
# number has to be 10 or less
  [ $userguess -le 10 ] || continue
  if [ $userguess -gt $secretnumber ]; then
    echo "Too high, try a marijuana-free state"
  elif [ $userguess -lt $secretnumber ]; then
    echo "Too low, get higher"
  else
    echo "You got it! Have a milkdud."
  fi
done
