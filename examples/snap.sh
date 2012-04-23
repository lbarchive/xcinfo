#!/bin/bash
# Snapping a picture when mouse has movements every 5 minutes
# Copyright (c) 2012 Yu-Jie Lin
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

while :; do
  read x y <<< "$($XCINFO)"
  POS="$x $y"
  if [[ $POS != $OLD_POS ]]; then
    filename="/tmp/snap-$(date +'%Y-%m-%d--%H:%M:%S.png')"
    xsnap -file "$filename" -region "${SW}x${SH}+0+0"
    OLD_POS="$POS"
    echo "$filename SNAP!"
  fi
  sleep 5m
done
