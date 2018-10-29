#!/bin/bash
file="/etc/resolv.conf"
if [ -f $file ]; then
  echo "file exists";
else
  echo "file does not exist";
fi

file="/bin/ls"
if [ -x "$file" ]; then
  echo "$file is executable"
else
  echo "$file is not executable"
fi

file="/tmp"
if [ -d "$file" ]; then
  echo "$file is a directory"
else
  echo "$file is not a directory"
fi

file="/etc/hosts"
if [ -d "$file" ]; then
  echo "$file is a directory"
else
  echo "$file is not a directory"
fi

file="/etc/shadow"
if [ -r "$file" ]; then
  echo "$file is a readable"
else
  echo "$file is not a readable"
fi

file="/etc/network/interfaces" # not complete
if [ -w "$file" ]; then
  echo "$file is a writeable"
else
  echo "$file is not a writeable"
fi

file="/bin/passwd" # not complete
if [ -w "$file" ]; then
  echo "$file is a writeable"
else
  echo "$file is not a writeable"
fi

file="/etc/hosts AND /etc/resolv.conf" # not complete
if [ -w "$file" ]; then
  echo "$file is a writeable"
else
  echo "$file is not a writeable"
fi

file="/bin/pidof" # not complete
if [ -w "$file" ]; then
  echo "$file is a writeable"
else
  echo "$file is not a writeable"
fi
