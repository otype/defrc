class Dmesg  
  
  attr_accessor :collector
  
  def initialize
    #if $USE_FILE_INSTEAD_OF_CMD
    #  @collector = WholeLineTableParser.new($DEBUG_SOURCE_DIR + "dmesg.out")
    #else
      @collector = WholeLineTableParser.new($SYSTEM_BIN_DIR + "dmesg")
    #end
    #@collector.use_file_instead_of_cmd($USE_FILE_INSTEAD_OF_CMD)
    @collector.run_splitter
  end

  def to_json
    @collector.to_json
  end

  def to_csv
    @collector.to_csv
  end

end