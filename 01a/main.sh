#!/usr/bin/env bash

if [[ $1 == "--help" || $1 == "-h" ]]; then
  echo "Count and return number of increases."
  echo "Use CTRL-D to end user input."
  echo "Usage: $0 [FILE]"
  exit
fi

PREV=""
INCREASES="0"

while read -r line
do
  if [[ $PREV && $line -gt $PREV ]]; then
    (( ++INCREASES ))
  fi
  PREV="$line"
done < "${1:-/dev/stdin}"

echo "$INCREASES"
