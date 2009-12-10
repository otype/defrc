class Dfk
  include ModSkeletton
  
  attr_accessor :collector
  
  def initialize
    @collector = TableParser.new($SYSTEM_BIN_DIR + "df -k")
    @collector.is_a_file(false)

    newheader = ["Filesystem", "Size", "Used", "Available", "Use%", "Mounted on"]
    @collector.override_header(newheader)
    @collector.run_splitter
  end
 
end