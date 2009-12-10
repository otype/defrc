###################################################################
#
# DEF - DATA  EXTRACTION FRAMEWORK
#
# RICollectorManager.rb
#
# DEF's Ruby Interface Collector Manager
#
# Created by Hans-Gunther Schmidt on Mon Aug 17 17:15:31 CEST 2009
# Contact via E-Mail: hans-gunther.schmidt@dai-labor.de
# Copyright 2009 DAI Labor. All rights reserved.
#
###################################################################

#$DEFPATH = File.dirname(__FILE__)
#require $DEFPATH + '/../config.rb'
#require $DEFPATH + '/../collectors/libs'

# ##############################################
# CLASSES
# ##############################################

class RICollectorManager
  attr_reader :collector_modules

  def initialize
    @collector_modules = Array.new
    scan_collectors    
  end

  private
  
  def scan_collectors
    Dir.entries('../collectors').each { |entry|
      @collector_modules << entry.strip if entry.start_with?("CL")
    }
  end

  
end

ricm = RICollectorManager.new
puts ricm.collector_modules

