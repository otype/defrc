class CLProcCpuinfo < CollectorModule
  
  def self.info
    "CLCpuinfo delivers CPU information from /proc/cpuinfo"
  end

  def self.version
    "0.1"
  end

  def self.category
    "Hardware"
  end

  def self.params
    ""
  end

  def self.weight
    "light"
  end

  def self.ptype
    "static"
  end
  
  def self.run
    (process.merge({ "TIME" => "#{formatted_time}" })).inspect.gsub("=>",":")
  end
  
  private
  
  def self.process
    result_hash = Hash.new
    File.read("/proc/cpuinfo").each_line do |line|
      if line.match(":")
        s = line.split(":")
        result_hash[s[0].strip] = numeric s[1].strip
      end
    end
    result_hash
  end

end
