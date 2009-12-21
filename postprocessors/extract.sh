#!/bin/bash

DATE=`date "+%Y%m%d_%H%M%S"`
LOGFILE="${DATE}.def.g1.log"
LOGFILEZIP="$LOGFILE.gz"
NEWZIPFILES="new/$LOGFILE.gz"

cd ~/Analysis

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
