class NetstatRN
  include ModSkeletton
  
  attr_accessor :collector
  
  def initialize
    @collector = TableParser.new($SYSTEM_BIN_DIR + "netstat -rn")
    @collector.is_a_file(false)
    
    newheader = ["Proto", "Recv-Q", "Send-Q", "Local Address", "Foreign Address", "State"]
    @collector.override_header(newheader)
    @collector.run_splitter
  end
 
end