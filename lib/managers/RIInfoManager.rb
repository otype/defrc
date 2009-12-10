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
require $DEFPATH + '../config.rb'
require $DEFPATH + '../collectors/libs'

# ##############################################
# CLASSES
# ##############################################

class RIInfoManager
  attr_accessor :name

  def collectors
    
  end
end