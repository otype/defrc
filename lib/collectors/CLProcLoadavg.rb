class CLProcLoadavg < CollectorModule
    
  def self.info
    "CLProcLoadavg delivers load average figures from /proc/loadavg"
  end

  def self.version
    "0.1"
  end

  def self.category
    "System"
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
    loadavg = File.read("/proc/loadavg").split
    result_hash['LAST_1_MINUTES'] = numeric loadavg[0]
    result_hash['LAST_5_MINUTES'] = numeric loadavg[1]
    result_hash['LAST_15_MINUTES'] = numeric loadavg[2]
    result_hash['EXECUTING_THREADS'] = numeric loadavg[3].split("/")[0]
    result_hash['EXISTING_THREADS'] = numeric loadavg[3].split("/")[1]
    result_hash['LAST_CREATED_PID'] = numeric loadavg[4]
    result_hash
  end

end
