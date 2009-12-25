#/bin/bash

ARGS="$*"

ZCAT="zcat"
if [ `uname` == "Darwin" ]; then
   ZCAT="gzcat
fi

for arg in $ARGS
do 
   echo $arg
   $ZCAT $arg | 
   sed 's/^RUN : //' | 
   grep "^{" | 
   sed 's/:nil/\"\"/g' | 
   sed 's/\"/\\"/g' | 
   sed 's/Groups\\\"\\\"/Groups\\\":\\\"/g' | 
   sed 's/runnable tasks\\\"\\\"/runnable tasks\\\":\\\"/g' | 
   sed 's/\[0\]\\\"\\\"/\[0\]\\\":\\\"/g' |
   sed 's/\\\"\\\"\\\"/\\\":\\\"\\\"/g' |
   gzip > clean_$arg
done

