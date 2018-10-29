#!/bin/bash -x

dirname="$1"
if [ -z "$dirname" ]; then
	echo "You didn't give me a directory name on the command line" >&2
	exit 1
fi
if [ ! -d "$dirname" ]; then
	echo "$dirname is not a directory" >&2
	exit 2
fi
if [ ! -r "$dirname" ]; then
	echo "You don't have read permission for $dirname" >&2
	exit 3
fi
if [ ! -x "$dirname" ]; then
	echo "You don't have access permission for $dirname" >&2
	exit 3
fi

echo "Directories with many files may take a while to search, be patient"
echo
echo "Setuid files:"
find "$dirname" -type f -executable -perm -4000 -ls 2>/dev/null | sort -k 3
echo
echo "Setgid files:"
find "$dirname" -type f -executable -perm -2000 -ls 2>/dev/null | sort -k 4
echo
