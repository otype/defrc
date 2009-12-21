#/bin/bash

#for i in *def.g1.log.gz; do gzcat $i | sed 's/^RUN : //' | grep "^{" | sed 's/:nil/\"\"/g' | gzip > clean_$i; done

#for i in *def.g1.log.gz
ARGS="$*"
ZCAT="zcat"
for i in $ARGS
do 
   echo $i
   $ZCAT $i | 
   sed 's/^RUN : //' | 
   grep "^{" | 
   sed 's/:nil/\"\"/g' | 
   sed 's/\"/\\"/g' | 
   sed 's/Groups\\\"\\\"/Groups\\\":\\\"/g' | 
   sed 's/runnable tasks\\\"\\\"/runnable tasks\\\":\\\"/g' | 
   sed 's/\[0\]\\\"\\\"/\[0\]\\\":\\\"/g' |
   sed 's/\\\"\\\"\\\"/\\\":\\\"\\\"/g' |
   gzip > clean_$i
done

