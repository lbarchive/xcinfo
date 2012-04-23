#!/bin/bash

XCINFO=xcinfo
IN_FILE=/dev/stdin
OUT_FILE=/dev/stdout

if ! type $XCINFO &>/dev/null; then
  if [[ -x ../xcinfo ]]; then
    XCINFO=../xcinfo
  else
    echo "Cannot find executable xcinfo." >&2
    exit 1
  fi
fi

if (( $# != 2 )); then
  echo "Usage: $0 <in_file> <out_svg>" >&2
  exit 1
fi

if [[ "$1" != - ]]; then
  IN_FILE="$1"
fi

if [[ "$2" != - ]]; then
  OUT_FILE="$2"
fi

# Get screen width and height
read _ _ SW SH _ <<< "$($XCINFO)"

echo '<?xml version="1.0"?>  
<svg width="1680" height="1050"
     xmlns="http://www.w3.org/2000/svg" version="1.1"  
     xmlns:xlink="http://www.w3.org/1999/xlink">  
<defs>
  <radialGradient id="g">  
    <stop offset="0" stop-color="#000" stop-opacity="1"/>
    <stop offset="1" stop-color="#000" stop-opacity="0"/>
  </radialGradient>  
</defs>' > "$OUT_FILE"

# Use uniq to remove repeating records because the inactivity of mouse
while read x y; do
  echo '<circle fill="url(#g)" r="10" cx="'$x'" cy="'$y'"/>'
done < <(uniq "$IN_FILE") >> "$OUT_FILE"

echo '</svg>' >> "$OUT_FILE"
