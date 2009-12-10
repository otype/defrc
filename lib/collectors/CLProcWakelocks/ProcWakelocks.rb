class ProcWakelocks
  include ModSkeletton
  
  attr_accessor :collector
  
  def initialize
    @collector = TableParser.new($PROC_DIR + "wakelocks")
    @collector.is_a_file(true)
    @collector.run_splitter
    remove_double_commas
    remove_double_quotations
  end

  def remove_double_commas
    body = Array.new
    @collector.body.each do |elem|
      body << elem.map { |v| v.delete(",") }
    end
    @collector.body = body
  end

  def remove_double_quotations
    body = Array.new
    @collector.body.each do |elem|
      body << elem.map { |v| v.delete("\"") }
    end
    @collector.body = body
  end

end