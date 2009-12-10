class CLProcGeneric

  attr_reader :filename, :skiplines, :splitter
  
  def initialize(filename, skiplines, splitter)
    @filename = filename
    @skiplines = skiplines
    @splitter = splitter
  end

  def to_json
    (ProcGeneric.new(@filename,@skiplines,@splitter)).to_json
  end

  def to_csv
    (ProcGeneric.new(@filename,@skiplines,@splitter)).to_csv
  end
  
  def header_to_csv
    (ProcGeneric.new(@filename,@skiplines,@splitter)).header_to_csv
  end

  def body_to_csv
    (ProcGeneric.new(@filename,@skiplines,@splitter)).body_to_csv
  end

end