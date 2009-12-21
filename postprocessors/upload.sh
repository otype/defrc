#!/bin/bash

for i in new/*gz
do
filename=`basename $i`
scp $i otype.de:/home/hgschmidt/Analysis/$filename
mv $i $filename
done
