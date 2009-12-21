class CLDumpsysUsagestats < CollectorModule

  def self.info
    "CLDumpsysUsagestats delivers application usage statistics"
  end

  def self.version
    "0.1"
  end

  def self.category
    "Process"
  end

  def self.params
    ""
  end

  def self.weight
    "medium"
  end

  def self.ptype
    "dynamic"
  end
  
  def self.run
    begin
      (process.merge({ "TIME" => "#{formatted_time}" })).inspect.gsub("=>",":")
    rescue Exception -> msg
      log_error(msg)      
    end
  end
  
  private

  def self.process
    cmd = %x{/system/bin/dumpsys usagestats}.split("\n")
    
    # Get rid of top 4 lines
    4.times { cmd.shift }

    thedate = String.new        
    result_hash = Hash.new

    cmd.each do |line|
      if line.match /^Date/
        thedate = (line.split(":"))[1].strip
        result_hash[thedate] = Array.new
      end
      result_hash[thedate] << split_line(line) if line.match /^pkg/
    end    
    result_hash
  end

  def self.split_line(line)
    arr = Array.new
    line.split(",").each { |elem| arr << numeric(elem.split("=")[1]) }
    arr[2] = numeric((arr[2].split)[0])
    {
      "NAME" => arr[0],
      "LAUNCHCOUNT" => arr[1],
      "USAGETIME" => arr[2]
    }
  end

end
