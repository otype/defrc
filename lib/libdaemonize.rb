###################################################################
#
# DEF - DATA  EXTRACTION FRAMEWORK
#
# libdaemonize.rb
#
# Offers a module that easily lets applications daemonize.
#
# Created by Hans-Gunther Schmidt on Thu Feb  5 16:29:56 CET 2009.
# Contact via E-Mail: hans-gunther.schmidt@dai-labor.de
# Copyright 2009 Hans-Gunther Schmidt (DAI Labor). 
# All rights reserved.
#
###################################################################

module Daemon
  WorkingDirectory = File.expand_path(File.dirname(__FILE__))  

  class Base
    def self.pid_fn
      File.join(WorkingDirectory, "#{name}.pid")
    end

    def self.daemonize
      Controller.daemonize(self)
    end
  end

  module PidFile
    def self.store(daemon, pid)
      File.open(daemon.pid_fn, 'w') {|f| f << pid}
    end

    def self.recall(daemon)
      IO.read(daemon.pid_fn).to_i rescue nil
    end
  end

  module Controller
    def self.daemonize(daemon)
      case !ARGV.empty? && ARGV[0]
      when 'start'
        start(daemon)
      when 'stop'
        stop(daemon)
      when 'restart'
        stop(daemon)
        start(daemon)
      when 'test'
        test(daemon)
      else
        puts ">>> ERROR: Invalid command!"
        puts ">>> Please run with appropriate paramater:"
        puts " "
        puts "     $ <script_name> {start|stop|restart|test}"
        puts " "
        exit
      end
    end

    def self.start(daemon)
      puts ">>> Daemonizing ..."
      fork do
        Process.setsid
        exit if fork
        PidFile.store(daemon, Process.pid)
        Dir.chdir WorkingDirectory
        File.umask 0000
        STDIN.reopen "/dev/null"
        STDOUT.reopen "/dev/null", "a"
        STDERR.reopen STDOUT
        trap("TERM") {daemon.stop; exit}
        daemon.start
      end
    end

    def self.stop(daemon)
      puts ">>> Stopping daemon ..."
      if !File.file?(daemon.pid_fn)
        puts ">>> ERROR: Pid file not found! Is the daemon started?"
        exit
      end
      pid = PidFile.recall(daemon)
      %x{rm #{daemon.pid_fn}}
      pid && Process.kill("TERM", pid)
      puts ">>> Stopped!"
    end

    def self.test(daemon)
      daemon.test
    end
  end
end

