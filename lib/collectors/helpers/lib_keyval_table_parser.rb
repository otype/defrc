class KeyValTableParser

  attr_reader :filename, :skiplines, :body, :splitter
  attr_accessor :keys, :values
  
  def initialize(filename, splitter)
    @filename = filename
    @splitter = splitter
    @body = Array.new
    @keys = Array.new
    @values = Array.new
    @skiplines = 0  #default
  end

  def run_splitter    
    @body = read_file_content
    Helpers.skip_lines(@body, @skiplines)
    simple_split
  end

  def to_csv
    header_to_csv + "\n" + body_to_csv
  end

  def body_to_csv
    array_to_csv(@values)
  end

  def header_to_csv
    array_to_csv(@keys)
  end

  def to_json
    array_to_json
  end

  def skip_header_lines(skiplines)
    @skiplines = skiplines
  end

  private

  def array_to_csv(arr)
    ans = String.new
    arr.each do |elem|
      elem = Helpers.remove_quotes_from_string(elem)
      ans += elem + (",")
    end
    return Helpers.remove_last_comma(ans)
  end

  def array_to_json    
    return "{ \"#{@filename}\" : \"\" }" if @keys.size != @values.size
    line = String.new
    0.upto(@keys.size) do |i|
      line += "\"#{@keys[i]}\" : \"#{@values[i]}\", "
    end    
    return "{ \"#{@filename}\" : [ #{Helpers.remove_last_comma(line)} ] }"
  end

  def read_file_content    
    File.readlines(@filename)
  end

  def simple_split
    arr = Array.new
    @body.each { |elem| arr << elem.split(@splitter) }
    arr.each do |k,v|
      k.nil? ? (@keys << "") : (@keys << Helpers.remove_quotes_from_string(k.chomp.strip))
      v.nil? ? (@values << "") : (@values << Helpers.remove_quotes_from_string(v.chomp.strip))
    end
    @body.clear
    Helpers.clean_array_elements(@keys)
    Helpers.clean_array_elements(@values)
  end
  
end