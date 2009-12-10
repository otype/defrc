class Df
  include ModSkeletton
  
  attr_accessor :collector
  
  def initialize
    @collector = TableParser.new($SYSTEM_BIN_DIR + "df")
    @collector.is_a_file(false)
    
    newheader = ["Filesystem", "Totalsize", "Total", "UsedSize", "Used", "AvailableSize", "Available", "Block Size"]
    @collector.override_header(newheader)
    @collector.run_splitter
    #remove_double_commas
  end

  def remove_double_commas
    body = Array.new
    @collector.body.each do |elem|
      body << elem.map { |v| v.delete(",") }
    end
    @collector.body = body
  end
end