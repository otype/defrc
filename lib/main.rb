###################################################################
#
# DEF - DATA  EXTRACTION FRAMEWORK
#
# def.rb
#
# Created by Hans-Gunther Schmidt on Thu Feb  5 16:29:56 CET 2009.
# Contact via E-Mail: hans-gunther.schmidt@dai-labor.de
# Copyright 2009 DAI Labor. All rights reserved.
#
###################################################################

# ##############################################
# GLOBALS
# ##############################################

$DEFPATH = File.dirname(__FILE__)
$SDCARD_DEF = "/sdcard/def"
$LOGFILE = "#{$SDCARD_DEF}/def.log"
$ERRORLOG = "#{$SDCARD_DEF}/errors.log"
$RESTARTLOG = "#{$SDCARD_DEF}/restart.log"
$INTERVALS = 5.0
$COLLECTOR_INTERVALS = 1.0
$DEBUG_MODE = false   # Run more verbose output of each collector

# ##############################################
# REQUIRES
# ##############################################

require $DEFPATH + "/libdaemonize.rb"

Dir[File.expand_path("#{$DEFPATH}/skelettons/*.rb")].uniq.each do |file|
  require file
end

Dir[File.expand_path("#{$DEFPATH}/collectors/CL*.rb")].uniq.each do |file|
  require file
end

# ##############################################
# CLASSES
# ##############################################

class DefDaemon < Daemon::Base  

  def self.start
    # Create /sdcard/def if it does not exist, yet!
    Dir.mkdir($SDCARD_DEF, 755) unless File.exists?($SDCARD_DEF)

    # Create log files in /sdcard/def
    @@logfd = File.new($LOGFILE, "a+")
    restart_log

    # MAIN LOOP
    loop do
      start_time = Time.new
      @@logfd.puts "\n=========================== #{start_time} ============================================\n"
      @@logfd.puts "PID = #{Process.pid}"
      @@logfd.puts "TIME NOW = #{start_time}"
      @@logfd.puts "$INTERVALS = #{$INTERVALS}s\n"
      @@logfd.puts "COLLECTOR $INTERVALS = #{$COLLECTOR_INTERVALS}s\n"

      $DEBUG_MODE ? run_debug_mode : run_normal_mode

      end_time = Time.new
      @@logfd.puts "TOTAL TIME = #{end_time - start_time}s"

      sleep $INTERVALS
    end
  end

  def self.running
    puts "Outside"
  end

  def self.stop    
    @@logfd.close
  end

  def self.test    
    puts ">>> Running in TEST mode (dump all to screen)"

    # list single collectors here for test, e.g.:
    puts CLProcAllPidsStatus.debug
  end

  private

  def self.restart_log
    File.open($RESTARTLOG, "a+") {|f| f.puts "#{Time.new}"}
  end

  def self.run_debug_mode
    @@logfd.puts CLProcUptime.debug
    @@logfd.puts CLProcMemInfo.debug
    @@logfd.puts CLProcLoadavg.debug
    @@logfd.puts CLProcCpuinfo.debug
    @@logfd.puts CLProcVmstat.debug
    @@logfd.puts CLProcSchedDebug.debug
    @@logfd.puts CLProcWakelocks.debug if RUBY_PLATFORM.match /arm-linux/
    @@logfd.puts CLProcYaffs.debug
    @@logfd.puts CLProcAllPidsStatus.debug
    @@logfd.puts CLSystemBinDf.debug
    @@logfd.puts CLDumpsysUsagestats.debug
    # Special for one single PID
    #@@logfd.puts CLProcPidStatus.debug
  end

  def self.run_normal_mode
    @@logfd.puts CLProcUptime.wait_and_run
    @@logfd.puts CLProcMemInfo.wait_and_run
    @@logfd.puts CLProcLoadavg.wait_and_run
    @@logfd.puts CLProcCpuinfo.wait_and_run
    @@logfd.puts CLProcVmstat.wait_and_run
    @@logfd.puts CLProcSchedDebug.wait_and_run
    @@logfd.puts CLProcWakelocks.wait_and_run if RUBY_PLATFORM.match /arm-linux/
    @@logfd.puts CLProcYaffs.wait_and_run
    @@logfd.puts CLProcAllPidsStatus.wait_and_run
    @@logfd.puts CLSystemBinDf.wait_and_run
    @@logfd.puts CLDumpsysUsagestats.wait_and_run

    # Special for one single PID
    #@@logfd.puts CLProcPidStatus.wait_and_run
  end
  
end

# ##############################################
# MAIN
# ##############################################

DefDaemon.daemonize
