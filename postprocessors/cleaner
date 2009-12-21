#!/bin/bash

LOGFILE=$1
RESULTFILE="$LOGFILE.filtered"

GREP=egrep
SED=sed
ZCAT=zcat

EXCLUDE_LIST="^(PID|TIME|INTERVALL|INFO|VERSION|CATEGORY|PARAMS|WEIGHT|PTYPE|RUN_DATE)"

$ZCAT $LOGFILE | 
	$GREP -v $EXCLUDE_LIST | 				# Get rid of irrelevant lines
	$SED "s/^RUN : //g" | 					# Remove the "Run : " statement
	$GREP "^(===|\{)" | 						# Only take lines starting with "===" or "{"
	$SED "s/nil/\"\"/g" > $RESULTFILE	# Replace those ugly "nil"-s with ""
