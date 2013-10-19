#!/bin/bash
# X cursor heatmap in terminal
# Copyright (c) 2013 Yu-Jie Lin
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Violet -> Red
RB=(129 92 55 56 21 26 31 36 41 46 82 118 154 190 226 220 214 208 202 196)
RBN=${#RB[@]}

XCINFO=xcinfo

if ! type $XCINFO &>/dev/null; then
  if [[ -x ../xcinfo ]]; then
    XCINFO=../xcinfo
  else
    echo "Cannot find executable xcinfo." >&2
    exit 1
  fi
fi


# Get screen width and height
read _ _ SW SH _ <<< "$($XCINFO)"
# Get terminal size
TW=$(tput cols)
TH=$(tput lines)

draw() {
  local H=$1 X=$2 Y=$3
  if ((H)); then
    ((RBIDX = H * (RBN - 1) / 100))
    C=${RB[RBIDX]}
  else
    C=16
  fi
  echo -ne "\e[$((Y + 1));$((X + 1))H\e[48;5;${C}m "
}


HM=()
for ((x=0; x<TW; x++)); do
  for ((y=0; y<TH; y++)); do
    ((IDX = x + y * TW, HM[IDX] = 0))
    draw ${HM[IDX]} $x $y
  done
done

RC=0
"$XCINFO" -i 10000 |
while read XX XY _; do
  ((TX = XX * TW / SW, TY = XY * TH / SH))
  ((IDX = TX + TY * TW, HM[IDX] = HM[IDX] + 5))
  ((HM[IDX] > 100)) && HM[IDX]=100
  draw ${HM[IDX]} $TX $TY
  if ((++RC >= 100)); then
    for ((x=0; x<TW; x++)); do
      for ((y=0; y<TH; y++)); do
        ((IDX = x + y * TW))
        if ((HM[IDX])); then
          ((HM[IDX]--))
          draw ${HM[IDX]} $x $y
        fi
      done
    done
    RC=0
  fi
done
