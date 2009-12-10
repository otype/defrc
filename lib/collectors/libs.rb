# Include helper libraries
require File.dirname(__FILE__) + '/helpers/libs'

# Include all shell command collector modules
require File.dirname(__FILE__) + '/CLDiskFree/libs'
require File.dirname(__FILE__) + '/CLDebugMessage/libs'
require File.dirname(__FILE__) + '/CLMount/libs'
require File.dirname(__FILE__) + '/CLNetstat/libs'
require File.dirname(__FILE__) + '/CLProcessList/libs'

# Include all proc command collector modules
require File.dirname(__FILE__) + '/CLProcSlabinfo/libs'
require File.dirname(__FILE__) + '/CLProcWakelocks/libs'
require File.dirname(__FILE__) + '/CLProcGeneric/libs'

# Include all dumpsys collector modules
require File.dirname(__FILE__) + '/CLDumpSysWifi/libs'
