###################################################################
#
# DEF - DATA  EXTRACTION FRAMEWORK
#
# debug.rb
#
# DEF's debug file in order to test all functions
#
# Created by Hans-Gunther Schmidt on Sun 26 Apr 2009 04:23:10 CEST.
# Contact via E-Mail: hans-gunther.schmidt@dai-labor.de
# Copyright 2009 DAI Labor. All rights reserved.
#
###################################################################

$DEFPATH = File.dirname(__FILE__)
require $DEFPATH + '/config.rb'
require $DEFPATH + '/libdaemonize.rb'
require $DEFPATH + '/collectors/libs'


# ##############################################
# CLASSES
# ##############################################

class Simple < Daemon::Base
  attr_reader :logfd
  attr_reader :netstatfd, :dffd, :psfd, :mountfd, :slabinfofd, :wakelocksfd
  attr_reader :dmesgfd, :cpuinfofd, :iomemfd, :ioportsfd, :vmstatfd
  attr_reader :yaffsfd, :mtdfd, :sched_debugfd, :meminfofd
  
  @CWD = "#{File.dirname(__FILE__)}"
  @INTERVALLS = 30.0
  @sddir = "/sdcard/def/"
  #@sddir = @CWD + "/logs/"

  def self.start
    @logfd = File.new("#{@sddir}/def.log", "a+")
    @netstatfd = File.new("#{@sddir}/netstatrn.log", "a+")
    @dffd = File.new("#{@sddir}/df.log", "a+")
    @psfd = File.new("#{@sddir}/ps.log", "a+")
    @mountfd = File.new("#{@sddir}/mount.log", "a+")
    @slabinfofd = File.new("#{@sddir}/slabinfo.log", "a+")
    @wakelocksfd = File.new("#{@sddir}/wakelocks.log", "a+")
    @dmesgfd = File.new("#{@sddir}/dmesg.log", "a+")
    @cpuinfofd = File.new("#{@sddir}/cpuinfo.log", "a+")
    @iomemfd = File.new("#{@sddir}/iomem.log", "a+")
    @ioportsfd = File.new("#{@sddir}/ioports.log", "a+")
    @vmstatfd = File.new("#{@sddir}/vmstat.log", "a+")
    @yaffsfd = File.new("#{@sddir}/yaffs.log", "a+")
    @mtdfd = File.new("#{@sddir}/mtd.log", "a+")
    @sched_debugfd = File.new("#{@sddir}/sched_debug.log", "a+")
    @smapsfd = File.new("#{@sddir}/smaps.log", "a+")
    @statusfd = File.new("#{@sddir}/status.log", "a+")
    @schedfd = File.new("#{@sddir}/sched.log", "a+")
    @meminfofd = File.new("#{@sddir}/meminfo.log","a+")

    loop do
      t = Time.new
      csvify(t)
      csvifypids(t)
      sleep @INTERVALLS
    end
  end

  def self.stop
    @logfd.close
    @netstatfd.close
    @dffd.close
    @psfd.close
    @mountfd.close
    @slabinfofd.close
    @wakelocksfd.close
    @dmesgfd.close
    @cpuinfofd.close
    @iomemfd.close
    @ioportsfd.close
    @vmstatfd.close
    @yaffsfd.close
    @mtdfd.close
    @sched_debugfd.close
    @smapsfd.close
    @statusfd.close
    @schedfd.close
    @meminfofd.close
  end

  def self.procgeneric(filename,skiplines,splitter)
    (CLProcGeneric.new(filename, skiplines, splitter)).body_to_csv
  end

  def self.csvify(time)
    ti = "=================== #{time} ====================\n"
    @netstatfd.puts(ti + CLNetstat.netstatrn_body_to_csv.to_s)
    @dffd.puts(ti + CLDiskFree.df_body_to_csv.to_s)
    @psfd.puts(ti + CLProcessList.ps_body_to_csv.to_s)
    @mountfd.puts(ti + CLMount.mount_body_to_csv.to_s)
    @slabinfofd.puts(ti + CLProcSlabinfo.body_to_csv.to_s)
    @wakelocksfd.puts(ti + CLProcWakelocks.body_to_csv.to_s)    
    @dmesgfd.puts(ti + CLDebugMessage.dmesg_to_csv.to_s)
    @cpuinfofd.puts(ti + procgeneric("/proc/cpuinfo",0,":").to_s)
    @iomemfd.puts(ti + procgeneric("/proc/iomem",0,":").to_s)
    @ioportsfd.puts(ti + procgeneric("/proc/ioports",0,":").to_s)
    @vmstatfd.puts(ti + procgeneric("/proc/vmstat",0," ").to_s)
    @yaffsfd.puts(ti + procgeneric("/proc/yaffs",3," ").to_s)
    @mtdfd.puts(ti + procgeneric("/proc/mtd",1,":").to_s)
    @sched_debugfd.puts(ti + procgeneric("/proc/sched_debug",2,":").to_s)
    @meminfofd.puts(ti + procgeneric("/proc/meminfo",0,":").to_s)
  end

  def self.csvifypids(time)
    @smapsfd.puts("=================== #{time} ====================\n")
    @statusfd.puts("=================== #{time} ====================\n")
    @schedfd.puts("=================== #{time} ====================\n")

    pnames = Array.new
    Dir.entries("/proc").each do |e|
      pnames << "/proc/#{e}" if e.match(/[0-9]/)
    end

    pnames.each do |p|    
      @smapsfd.puts(procgeneric("#{p}/smaps",0,":").to_s + "\n") if File.exist?("#{p}/smaps")
      @statusfd.puts(procgeneric("#{p}/status",0,":").to_s + "\n") if File.exist?("#{p}/status")
      @schedfd.puts(procgeneric("#{p}/sched",2,":").to_s + "\n") if File.exist?("#{p}/sched")
    end
  end

end

# ##############################################
# MAIN
# ##############################################

Simple.daemonize
