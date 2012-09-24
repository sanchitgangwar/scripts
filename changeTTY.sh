#! /bin/bash
# Purpose: To change the TTY.

ttyNum="$(tty)"
ttyNum=$(echo ${ttyNum##*y})

ttyNum=$(( (ttyNum +1) % 7))
echo $ttyNum
chvt $ttyNum
