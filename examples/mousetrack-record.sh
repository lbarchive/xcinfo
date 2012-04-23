#!/bin/bash

XCINFO=xcinfo
OUT_FILE=/dev/stdout

if ! type $XCINFO &>/dev/null; then
  if [[ -x ../xcinfo ]]; then
    XCINFO=../xcinfo
  else
    echo "Cannot find executable xcinfo." >&2
    exit 1
  fi
fi

if (( $# != 1 )); then
  echo "Usage: $0 <file>" >&2
  exit 1
fi

if [[ "$1" != - ]]; then
  OUT_FILE="$1"
fi

echo "Press Q to stop recording"
while :; do
  read x y _ <<< "$($XCINFO)"
  echo "$x $y"
  read -t 0.1 -n 1 -s
  if [[ $REPLY == q ]]; then
    break
  fi
done > "$OUT_FILE"
