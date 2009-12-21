class CLProcMemInfo < CollectorModule    

  def self.info
    "CLProcMemInfo delivers memory status information from /proc/meminfo"
  end

  def self.version
    "0.1"
  end

  def self.category
    "Memory"
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
    begin
      (process.merge({ "TIME" => "#{formatted_time}" })).inspect.gsub("=>",":")
    rescue Exception -> msg
      log_error(msg)
    end
  end
  
  private
  
  def self.process
    result_hash = Hash.new
    File.read("/proc/meminfo").each_line do |line|
      s = line.split(":")
      result_hash[s[0]] = numeric((s[1].strip.split)[0])
    end
    result_hash
  end

end
