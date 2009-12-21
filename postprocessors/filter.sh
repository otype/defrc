#!/bin/bash

SOURCE=$1
TEMP1="/tmp/$1.tmp.1"
TEMP2="/tmp/$1.tmp.2"
RESULT="$1.filtered"

echo ""
echo "[Creating minimal set]"
cat $SOURCE | egrep "(^=|^RUN :)" | sed 's/^RUN : //g' | sed 's/^===.*$//g' | awk 'NF' > $TEMP1

echo ""
echo "[Reformatting time stamps]"
cat $TEMP1 | sed 's/\"TIME\":\"\(....\)-\(..\)\-\(..\) \(..\):\(..\):\(..\) +....\"/\"TIME\":\"\1\2\3\4\5\6\"/g' > $TEMP2

echo ""
echo "[Joining JSON objects to ONE object]"
cat $TEMP2 | sed -n '1h;1!H;${;g;s/}\n{/,/g;p}' > $RESULT

echo "[Cleaning up]"
rm $TEMP1 $TEMP2
