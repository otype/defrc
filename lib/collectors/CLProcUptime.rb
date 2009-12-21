class CLProcUptime < CollectorModule
  
  def self.info
    "CLProcUptime delivers /proc/uptime in JSON-syntax"
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
    begin
      (process.merge({ "TIME" => "#{formatted_time}" })).inspect.gsub("=>",":")
    rescue Exception -> msg
      log_error(msg)
    end      
  end

  private

  def self.process
    result_hash = Hash.new
    uptime = File.read("/proc/uptime").split
    result_hash['SYSTEM_UPTIME'] = numeric uptime[0]
    result_hash['IDLE_TIME'] = numeric uptime[1]
    result_hash
  end
end
