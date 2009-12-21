class CLProcWakelocks < CollectorModule

  def self.info
    "CLProcWakelocks delivers Android-specific information to given wakelocks (/proc/wakelocks)"
  end

  def self.version
    "0.1"
  end

  def self.category
    "Android"
  end

  def self.params
    ""
  end

  def self.weight
    "light"
  end

  def self.ptype
    "dynamic"
  end
  
  def self.run
    (process.merge({ "TIME" => "#{formatted_time}" })).inspect.gsub("=>",":")
  end
  
  private
  
  def self.process
    result_hash = Hash.new
    begin
      f = File.read("/proc/wakelocks").split("\n")  
      first_line = f.first      
      cols = first_line.split
      
      f.each do |line|
        next if line == first_line
        s = line.split
        next if s.size == 0
        key = s[0].strip.gsub("\"", "")
        result_hash[key] = process_line(s,cols)
      end
    rescue NoMethodError => nme
      result_hash = { "ERROR" => "#{nme}" }
    end        
    result_hash
  end

  def self.process_line(s,cols)
    mhash = Hash.new
    1.upto(cols.size - 1) do |i|
      mhash[cols[i]] = numeric(s[i])
    end
    mhash
  end

end
