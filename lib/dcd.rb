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

$DEFPATH = File.dirname(__FILE__)

require $DEFPATH + '/libdaemonize.rb'
require 'socket'

# ##############################################
# CLASSES
# ##############################################

class DCDaemon < Daemon::Base
#  attr_accessor   :logfd

  @CWD = "#{File.dirname(__FILE__)}"
  @LOGFILE = "#{@CWD}/data.log"
  @INTERVALLS = 5.0

  def self.start
    loop do
      Time.new
      puts "Starting daemon"
      sleep @INTERVALLS
    end
    
#    @logfd = File.new(@LOGFILE, "a+")
#    loop do
#      Time.new
#
#      $COLLECTION.each do |datacollector|
#        if datacollector.match(/:/)
#          cmd = datacollector.split(":")
#          @logfd.puts eval "#{cmd[0]} #{cmd[1]}"
#        else
#          @logfd.puts eval datacollector
#        end
#      end
#
#      sleep @INTERVALLS
#    end
  end

  def self.stop
    puts "Stopping daemon"
#    @logfd.close
  end

  def self.test
    puts "Test run"
#    puts ">>> Running in TEST mode (dump all to screen)"
#    $COLLECTION.each do |datacollector|
#      if datacollector.match(/:/)
#        cmd = datacollector.split(":")
#        puts eval "#{cmd[0]} #{cmd[1]}"
#      else
#        puts eval datacollector
#      end
#    end
  end
end

# ##############################################
# MAIN
# ##############################################

#$COLLECTION = DefConfig.new("#{$DEFPATH}/etc/def.config").collection
#Def.daemonize

DCDaemon.daemonize
