#!/bin/bash

CWD=`pwd`
DATE=`date "+%Y%m%d_%H%M%S"`
LOGFILE="$CWD/${DATE}.def.g1.log"
LOGFILEZIP="$CWD/$LOGFILE.gz"
NEWZIPFILES="$CWD/$LOGFILE.gz"

echo "[Pulling file from device]"
adb pull /sdcard/def/def.log $LOGFILE

echo "[Deleting PID file on device]"
adb shell rm /sdcard/def/PID 

echo "[Deleting log file on device]"
adb shell rm /sdcard/def/def.log

echo "[GZipping logfile]"
gzip $LOGFILE

echo "[Moving logfile to new folder]"
mv $LOGFILEZIP $NEWZIPFILES
