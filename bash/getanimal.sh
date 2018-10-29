#!/bin/bash
#
# this script demonstrates using arrays and user input

colours=("red" "green" "blue" "orange")
declare -A animals
animals=([red]="cardinal" [green]="frog" [blue]="lobster" [orange]="Lord Dampnut")

echo "The colours array contains
${colours[0]}, ${colours[1]}, ${colours[2]}, ${colours[3]}"
echo "Everything in the colours array retrieved using the @ special index comes out as:
${colours[@]}"

read -p "Pick a number from 1 to ${#colours[@]}: " num
colour=${colours[((num - 1))]}
animal=${animals[$colour]}
echo "Index $num finds a $colour $animal"
