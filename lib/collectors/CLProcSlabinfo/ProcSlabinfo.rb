class ProcSlabinfo
  include ModSkeletton
  
  attr_accessor :collector
  
  def initialize
    @collector = TableParser.new($PROC_DIR + "slabinfo")
    @collector.is_a_file(true)

    newheader = ["Name", "active_objs", "num_objs", "objsize", "objperslab",
      "pagesperslab", ":", "tunables", "limit", "batchcount", "sharedfactor",
      ":","slabdata", "active_slabs", "num_slabs", "sharedavail" ];
    @collector.override_header(newheader)
    @collector.skip_header_lines(2)
    @collector.run_splitter
    remove_double_commas
  end

  def remove_double_commas
    body = Array.new
    @collector.body.each do |elem|
      body << elem.map { |v| v.delete(",") }
    end
    @collector.body = body
  end
end