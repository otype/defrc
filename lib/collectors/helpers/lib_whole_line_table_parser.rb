class WholeLineTableParser

  attr_reader :shellcmd
  attr_reader :body
  #attr_accessor :usefile
  
  def initialize(shellcmd)
    @shellcmd = shellcmd    
    @body = Array.new
    #@usefile = false # default
  end

  def to_json
    Helpers.array_to_json(@shellcmd, @body)
  end
  
  def to_csv
    csv = String.new
    @body.each do |v|
      csv += v.chomp + ":::"
    end
    return csv
  end

  #def use_file_instead_of_cmd(param)
  #  @usefile = param
  #end

  def run_splitter
    @body = Helpers.clean_array_elements(read_cmd_to_array)
  end

  private

  def read_cmd_to_array    
    #(@usefile ? File.readlines(@shellcmd) : %x{#{@shellcmd}}).split("\n")
    %x{#{@shellcmd}}.split("\n")
  end
  
end