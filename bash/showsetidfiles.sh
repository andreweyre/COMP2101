#!/bin/bash
#
# this script generates a report of the files on the system that are setuid or setgid
# it is for the lab1 exercise

echo "Setuid files:"
find / -type f -executable -perm -4000 -ls 2>/dev/null | sort -k 3
echo
echo "Setgid files:"
find / -type f -executable -perm -2000 -ls 2>/dev/null | sort -k 4
echo
