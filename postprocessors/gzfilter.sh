#!/bin/bash

SOURCE=$1
TEMP1="/tmp/$1.tmp.1.gz"
TEMP2="/tmp/$1.tmp.2.gz"
RESULT="$1.filtered.gz"

echo ""
echo "[Creating minimal set]"
zcat $SOURCE | egrep "(^=|^RUN :)" | sed 's/^RUN : //g' | sed 's/^===.*$//g' | awk 'NF' | gzip > $TEMP1

echo ""
echo "[Reformatting time stamps]"
zcat $TEMP1 | sed 's/\"TIME\":\"\(....\)-\(..\)\-\(..\) \(..\):\(..\):\(..\) +....\"/\"TIME\":\"\1\2\3\4\5\6\"/g' | gzip > $TEMP2

echo ""
echo "[Joining JSON objects to ONE object]"
zcat $TEMP2 | sed -n '1h;1!H;${;g;s/}\n{/,/g;p}' | gzip > $RESULT

echo "[Cleaning up]"
rm $TEMP1 $TEMP2
