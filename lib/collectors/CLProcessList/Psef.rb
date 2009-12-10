class Psef
  include ModSkeletton
  
  attr_accessor :collector
  
  def initialize
    @collector = TableParser.new($SYSTEM_BIN_DIR + "ps -ef")
    @collector.is_a_file(false)
    
    @collector.header_exists(true)
    @collector.skip_header_lines(0)
    @collector.run_splitter
  end
 
end