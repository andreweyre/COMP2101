#!/bin/bash

myname="Andrew"
mytitle="Captain"
hostname=$(hostname)
today=$(date +%A)

echo "Welcome to ${hostname}, ${mytitle} ${myname}!"
echo "Today is ${today}."
