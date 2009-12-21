#!/bin/bash

for i in *g1.log.gz; do zcat $i | grep "LAUNCHCOUNT" | gzip >> groups/cldumpsysusagestats.log.gz; done;
for i in *g1.log.gz; do zcat $i | grep "TracerPid" | gzip >> groups/clprocallpidsstatus.log.gz; done;
for i in *g1.log.gz; do zcat $i | grep "BogoMIPS" | gzip >> groups/clcpuinfo.log.gz; done;
for i in *g1.log.gz; do zcat $i | grep "LAST_1_MINUTES" | gzip >> groups/clprocloadavg.log.gz; done;
for i in *g1.log.gz; do zcat $i | grep "MemTotal" | gzip >> groups/clprocmeminfo.log.gz; done;
for i in *g1.log.gz; do zcat $i | grep "\.sysctl_sched_latency" | gzip >> groups/clprocscheddebug.log.gz; done;
for i in *g1.log.gz; do zcat $i | grep "SYSTEM_UPTIME" | gzip >> groups/clprocuptime.log.gz; done;
for i in *g1.log.gz; do zcat $i | grep "nr_active_anon" | gzip >> groups/clprocvmstat.log.gz; done;
for i in *g1.log.gz; do zcat $i | grep "mddi_link_active_idle_lock" | gzip >> groups/clprocwakelocks.log.gz; done;
for i in *g1.log.gz; do zcat $i | grep "totalBytesPerChunk" | gzip >> groups/clprocyaffs.log.gz; done;
for i in *g1.log.gz; do zcat $i | grep "/sqlite_stmt_journals" | gzip >> groups/clsystembindf.log.gz; done

