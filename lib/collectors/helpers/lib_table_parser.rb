class TableParser
  include ParserHelper
  
  attr_reader :table, :shellcmd, :header, :header_columns
  attr_reader :headerexists
  attr_accessor :skiplines
  attr_accessor :body
  attr_accessor :usefile
  
  def initialize(shellcmd)
    @shellcmd = shellcmd
    @header = Array.new
    @body = Array.new    
    @headerexists = true  # default
    @skiplines = 0  #default
    @usefile = false #by default, assume we are handling a shell command
  end

  private  

  #
  # Transform given array into JSON object.
  #
  def array_to_json(arr)
    i = 0
    ans = String.new

    arr.each do |line|
      l = ""
      line.each do |elem|
        i = 0 if ((i % @header_columns) == 0)
        l += "\"#{@header[i]}\" : \"#{elem}\", "        
        i += 1
      end
      ans += "{ #{Helpers.remove_last_comma(l)} }, "
    end    
    return "{ \"#{@shellcmd}\" : [ #{Helpers.remove_last_comma(ans)} ] }"
  end
  
  # Use this method instead of split_header_and_body
  # if no header exists, e.g. mount does not provide
  # a table header. This requires @header must have
  # been set via override_header(newheader)
  def split_body
    out = @usefile ? File.readlines(@shellcmd).to_a : %x{#{@shellcmd}}.split("\n")
    Helpers.skip_lines(out, @skiplines)
    @header_columns = @header.size
    out.each do |elem|
      @body << align_body_columns_to_header_column(elem.split)
    end
  end

  #
  # Run the shell command (which has a table output)
  # and split header from table (body).
  # Implicitly fill up each line with nil-elements if
  # discrepancy of body line element to header elements
  # exists.
  #
  def split_header_and_body
    out = @usefile ? File.readlines(@shellcmd).to_a : %x{#{@shellcmd}}.split("\n")    
    Helpers.skip_lines(out, @skiplines)
    @header = out.delete(out.first).split
    @header_columns = @header.size
    
    out.each do |elem|
      @body << align_body_columns_to_header_column(elem.split)
    end
  end

end