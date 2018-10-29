#!/bin/bash
#this script does arithmetic
read -p "Give me 2 numbers: " firstnum secondnum
echo "$firstnum plus $secondnum is $((firstnum + secondnum))"
echo "$firstnum minus $secondnum is $((firstnum - secondnum))"
echo "$firstnum times $secondnum is $((firstnum * secondnum))"
echo "$firstnum divided by $secondnum is $((firstnum / secondnum))"
echo "It is also $(awk "BEGIN{printf \"%.2f\", $firstnum/$secondnum}")"
echo "The remainder when dividing $firstnum by $secondnum is $((firstnum % secondnum))"
echo "$firstnum to the power of $secondnum is $(bc <<< "$firstnum ^ $secondnum")"
