class CLProcYaffs < CollectorModule    

  def self.info
    "CLProcYaffs delivers YAFFS filesystem information from /proc/yaffs"
  end

  def self.version
    "0.1"
  end

  def self.category
    "Filesystem"
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
    yaffs = File.read("/proc/yaffs")

    # Get all device names
    devices = Array.new
    yaffs.each_line do |line|
      devices << ((line.split)[2]).strip if line.match /^Device/
    end

    # Split output into device blocks
    blocks = yaffs.split("Device")

    # Read each block
    mhash = Hash.new
    1.upto(devices.size-1) do |i|      
      blocks[i].each_line do |line|        
        if line.match /\.\ /          
          s = line.split
          mhash[s[0].gsub(".","")] = numeric(s[1].strip)
        end
      end
      result_hash[devices[i].gsub("\"","")] = mhash
    end

    result_hash
  end

end
