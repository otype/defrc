class CLSystemBinDf < CollectorModule    

  def self.info
    "CLSystemBinDf delivers disk free status information"
  end

  def self.version
    "0.1"
  end

  def self.category
    "Disk"
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
    cmd = %x{/system/bin/df}

    result_hash = Hash.new
    cmd.each_line do |line|
      s = line.split
      filesystem = s[0].strip.gsub(":","")      
      total = numeric(s[1].strip.gsub("K",""))
      used = numeric(s[3].strip.gsub("K",""))
      avail = numeric(s[5].strip.gsub("K",""))

      result_hash = result_hash.merge({
        "TOTAL(#{filesystem})" => total,
        "USED(#{filesystem})" => used,
        "AVAILABLE(#{filesystem})" => avail
      })
    end
    
    result_hash
  end

end
