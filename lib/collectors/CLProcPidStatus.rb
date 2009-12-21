class CLProcPidStatus < CollectorModule    

  def self.info
    "CLProcPidStatus delivers process status information for a single PID from /proc/<PID>/status"
  end

  def self.version
    "0.1"
  end

  def self.category
    "Process"
  end

  def self.params
    "PID"
  end

  def self.weight
    "medium"
  end

  def self.ptype
    "dynamic"
  end
  
  def self.run(pid)
    begin
      ((process(pid).merge(pid_sched(pid))).merge({ "TIME" => "#{formatted_time}" })).inspect.gsub("=>",":")
    rescue Exception -> msg
      log_error(msg)
    end      
  end

  def self.debug
    "INFO : " + info + "\n" +
    "VERSION : " + version + "\n" +
    "CATEGORY : " + category + "\n" +
    "PARAMS : " + params + "\n" +
    "WEIGHT : " + weight + "\n" +
    "PTYPE : " + ptype + "\n" +
    "RUN_DATE : " + "#{formatted_time}\n" +
    "RUN : " + run(1) + "\n\n"
  end

  private
  
  def self.process(pid)
    result_hash = Hash.new
    File.read("/proc/#{pid}/status").each_line do |line|
      s = line.split(":")
      if (line.match /^Sig/ or line.match /^Cap/)
        result_hash[s[0]] = (s[1].strip.split)[0]
      else
        result_hash[s[0]] = numeric((s[1].strip.split)[0])
      end
    end
    result_hash
  end

  def self.pid_sched(pid)
    result_hash = Hash.new
    File.read("/proc/#{pid}/sched").each_line do |line|
      if line.match /\ :\ /
        s = line.split(":")
        result_hash[s[0].strip] = numeric((s[1].strip.split)[0])
      end
    end
    result_hash
  end
  
end
