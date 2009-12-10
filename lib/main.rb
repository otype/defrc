###################################################################
#
# DEF - DATA  EXTRACTION FRAMEWORK
#
# main.rb
#
# DEF's main
#
# Created by Hans-Gunther Schmidt on Sun 26 Apr 2009 04:23:10 CEST.
# Contact via E-Mail: hans-gunther.schmidt@dai-labor.de
# Copyright 2009 DAI Labor. All rights reserved.
#
###################################################################

$DEFPATH = File.dirname(__FILE__)
require $DEFPATH + '/config.rb'
require $DEFPATH + '/collectors/libs'


#
# ALL USING TableParser
#

#puts CLNetstat.netstatrn_to_csv
#puts CLNetstat.netstatrn_header_to_csv
#puts CLNetstat.netstatrn_body_to_csv
#puts CLNetstat.netstatrn_to_json

# [NOT IN ANDROID]
#puts CLDiskFree.dfh_to_csv
#puts CLDiskFree.dfh_header_to_csv
#puts CLDiskFree.dfh_body_to_csv
#puts CLDiskFree.dfh_to_json

# [NOT IN ANDROID]
#puts CLDiskFree.dfk_to_csv
#puts CLDiskFree.dfk_header_to_csv
#puts CLDiskFree.dfk_body_to_csv
#puts CLDiskFree.dfk_to_json

#puts CLDiskFree.df_to_csv
#puts CLDiskFree.df_header_to_csv
#puts CLDiskFree.df_body_to_csv
#puts CLDiskFree.df_to_json

#puts CLProcessList.ps_to_csv
#puts CLProcessList.ps_header_to_csv
#puts CLProcessList.ps_body_to_csv
#puts CLProcessList.ps_to_json

#puts CLMount.mount_to_csv
#puts CLMount.mount_header_to_csv
#puts CLMount.mount_body_to_csv
#puts CLMount.mount_to_json

#puts CLProcSlabinfo.to_csv
#puts CLProcSlabinfo.header_to_csv
#puts CLProcSlabinfo.body_to_csv
#puts CLProcSlabinfo.to_json

#puts CLProcWakelocks.to_csv
#puts CLProcWakelocks.header_to_csv
#puts CLProcWakelocks.body_to_csv
#puts CLProcWakelocks.to_json

#
# ALL USING WholeLineTableParser
#

puts CLDebugMessage.dmesg_to_csv
puts CLDebugMessage.dmesg_to_json

#
# ALL USING KeyValTableSplitter
#

#smaps = CLProcGeneric.new("/proc/1/smaps",0,":")
#puts smaps.to_csv
#puts smaps.header_to_csv
#puts smaps.body_to_csv
#puts smaps.to_json

#cpuinfo = CLProcGeneric.new("/proc/cpuinfo",0,":")
#puts cpuinfo.to_csv
#puts cpuinfo.header_to_csv
#puts cpuinfo.body_to_csv
#puts cpuinfo.to_json

#status = CLProcGeneric.new("/proc/1/status",0,":")
#puts status.to_csv
#puts status.header_to_csv
#puts status.body_to_csv
#puts status.to_json

#procstat = %x{/data/def/getprocstat 1}
#puts procstat


#sched = CLProcGeneric.new("/proc/1/sched",2,":")
#puts sched.to_csv
#puts sched.header_to_csv
#puts sched.body_to_csv
#puts sched.to_json

#iomem = CLProcGeneric.new("/proc/iomem",0,":")
#puts iomem.to_csv
#puts iomem.header_to_csv
#puts iomem.body_to_csv
#puts iomem.to_json

#ioports = CLProcGeneric.new("/proc/ioports",0,":")
#puts ioports.to_csv
#puts ioports.header_to_csv
#puts ioports.body_to_csv
#puts ioports.to_json

#vmstat = CLProcGeneric.new("/proc/vmstat",0," ")
#puts vmstat.to_csv
#puts vmstat.header_to_csv
#puts vmstat.body_to_csv
#puts vmstat.to_json

#yaffs = CLProcGeneric.new("/proc/yaffs",3," ")
#puts yaffs.to_csv
#puts yaffs.header_to_csv
#puts yaffs.body_to_csv
#puts yaffs.to_json

#mtd = CLProcGeneric.new("/proc/mtd",1,":")
#puts mtd.to_csv
#puts mtd.header_to_csv
#puts mtd.body_to_csv
#puts mtd.to_json

#meminfo = CLProcGeneric.new("/proc/meminfo",0,":")
#puts meminfo.to_csv
#puts meminfo.header_to_csv
#puts meminfo.body_to_csv
#puts meminfo.to_json


#
# SPECIALS
#

#sched_debug = CLProcGeneric.new("/proc/sched_debug",2,":")
#puts sched_debug.to_csv
#puts sched_debug.header_to_csv
#puts sched_debug.body_to_csv
#puts sched_debug.to_json

#timer_list = CLProcGeneric.new("/proc/timer_list",0,":")
#puts timer_list.to_csv
#puts timer_list.header_to_csv
#puts timer_list.body_to_csv
#puts timer_list.to_json


#
# DUMPSYS
#
#puts CLDumpSysWifi.dumpsys_wifi_to_csv
#puts CLDumpSysWifi.dumpsys_wifi_header_to_csv
#puts CLDumpSysWifi.dumpsys_wifi_body_to_csv
#puts CLDumpSysWifi.dumpsys_wifi_to_json