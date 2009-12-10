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

class ProcPids
  attr_reader :pids, :pnames

  def initialize
    @pids = Array.new
    @pnames = Array.new
    readpids
  end

  def pidpaths
    @pnames
  end

  def pids
    @pids
  end

  private

  def readpids
    Dir.entries("/proc/").each do |e|
      @pids << e if e.match(/[0-9]/)
      @pnames << "/proc/#{e}" if e.match(/[0-9]/)
    end
  end
end

class Debug < Daemon::Base
  attr_reader :logfd
  attr_reader :netstatfd, :dffd, :psfd, :mountfd, :slabinfo, :wakelocksfd
  attr_reader :dmesgfd, :cpuinfofd, :iomemfd, :ioportsfd, :vmstatfd, :yaffsfd
  attr_reader :mtdfd, :sched_debugfd, :smapsfd, :statusfd, :schedfd
  attr_reader :sddir
  
  @CWD = "#{File.dirname(__FILE__)}"
  @LOGFILE = "/sdcard/def.log"
  @INTERVALLS = 30.0
  @sddir = "/sdcard/def/"

  def self.start
    #@logfd = File.new("#{@sddir}/def.log", "a+")
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
    
    loop do
      t = Time.new
      #@logfd.puts csvify(t)    
      this.csvify(t)
      sleep @INTERVALLS
    end
  end

  def self.stop
    #@logfd.close
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
  end

  def self.procgeneric(filename,skiplines,splitter)
    (CLProcGeneric.new(filename, skiplines, splitter)).to_csv
  end

  def self.procgenericpid(filename,skiplines,splitter)
    this.procgeneric(filename, skiplines, splitter)
  end


  def self.csvify(time)
    ti = "|||||||||||||||||| #{time} |||||||||||||||||||||||||\n"
    puts ti
    @netstatfd.puts(ti + CLNetstat.netstatrn_body_to_csv)
    @dffd.puts(ti + CLDiskFree.df_body_to_csv)
    @psfd.puts(ti + CLProcessList.ps_body_to_csv)
    @mountfd.puts(ti + CLMount.mount_body_to_csv)
    @slabinfofd.puts(ti + CLProcSlabinfo.body_to_csv)
    @wakelocksfd.puts(ti + CLProcWakelocks.body_to_csv)
    @dmesgfd.puts(ti + CLDebugMessage.dmesg_to_csv)

    @cpuinfofd.puts(ti + this.procgeneric("/proc/cpuinfo",0,":"))
    @iomemfd.puts(ti + this.procgeneric("/proc/iomem",0,":"))
    @ioportsfd.puts(ti + this.procgeneric("/proc/ioports",0,":"))
    @vmstatfd.puts(ti + this.procgeneric("/proc/vmstat",0," "))
    @yaffsfd.puts(ti + this.procgeneric("/proc/yaffs",3," "))
    @mtdfd.puts(ti + this.procgeneric("/proc/mtd",1,":"))
    @sched_debugfd.puts(ti + this.procgeneric("/proc/sched_debug",2,":"))

    pids = ProcPids.new
    pids.pidpaths.each do |p|
      @smapsfd.puts(ti + this.procgenericpid("#{p}/smaps",0,":")) if File.exist?(p)
      @statusfd.puts(ti + this.procgenericpid("#{p}/status",0,":")) if File.exist?(p)
      @schedfd.puts(ti + this.procgenericpid("#{p}/sched",2,":")) if File.exist?(p)
    end
  end

end

# ##############################################
# MAIN
# ##############################################

Debug.daemonize
