class Mount
  include ModSkeletton
  
  attr_accessor :collector
  
  def initialize
    @collector = TableParser.new($SYSTEM_XBIN_DIR + "bb/mount")
    @collector.is_a_file(false)

    newheader = ["Filesystem", "Mount Point", "FSType", "Mount Options", "Dump", "Pass"]
    @collector.override_header(newheader)
    @collector.header_exists(false)
    @collector.skip_header_lines(1)
    @collector.run_splitter
  end
end