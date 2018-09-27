#!/bin/bash
declare -A foo
foo=([key1]="data1" [key2]="data2")
echo "The value for key 'key1' is '${foo[key1]}'"
echo "The value for key 'key2' is '${foo[key2]}'"
echo "The values for all elements are:
${foo[@]}"
echo "There are ${#foo[@]} key-value pairs in the hash"
echo "The keys for all elements are:
${!foo[@]}"
