class ProcGeneric
  include ModSkeletton
  
  attr_accessor :collector
  
  def initialize(filename,skiplines,splitter)
    @collector = KeyValTableParser.new(filename, splitter)
    @collector.skip_header_lines(skiplines)
    @collector.run_splitter
  end
end