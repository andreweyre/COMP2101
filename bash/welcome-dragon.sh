#!/bin/bash

myname="Andrew"
titles=("Boss" "Captain" "Chief" "Pal" "Amigo")
title_index=$((RANDOM % ${#titles[@]}))
mytitle=${titles[$title_index]}
hname=$(hostname)
today=$(date +%A)

welcome_message="
Welcome to planet ${hname}, $mytitle ${myname}!
Today is ${today}.
"
echo $welcome_message | cowsay -f dragon
