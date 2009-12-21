class CLProcAllPidsStatus < CollectorModule    

  def self.info
    "CLProcAllPidsStatus delivers process status information for all PIDS from /proc/<PID>/status"
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
    "very heavy"
  end

  def self.ptype
    "dynamic"
  end
  
  def self.run
    (process.merge({ "TIME" => "#{formatted_time}" })).inspect.gsub("=>",":").gsub("\\x00", " ")
  end
  
  private

  #
  # Style 1: { "<PID>" : { all values } }
  #
  def self.process
    rhash = Hash.new
    all_pids.each do |pid|     
      process_name, temp_hash = process_pid(pid) if File.exists? "/proc/#{pid}"
      cmdline = File.read("/proc/#{pid}/cmdline") if File.exists?("/proc/#{pid}/cmdline")    
      cmdline.strip.empty? ? rhash[process_name] = temp_hash : rhash[cmdline.strip] = temp_hash
    end    
    
    rhash
  end

  def self.process_pid(pid)
    result_hash = Hash.new
    process_name = String.new
    
    File.read("/proc/#{pid}/status").each_line do |line|    
      s = line.split(":")
      process_name = s[1].strip if line.match /^Name:/

      unless line.match /^Groups/
        if (line.match /^Sig/ or line.match /^Cap/)
          result_hash[s[0]] = (s[1].strip.split)[0]
        else
          result_hash[s[0]] = numeric((s[1].strip.split)[0])
        end
      end
    end
    [process_name, result_hash.merge(pid_sched(pid))]
  end

  def self.pid_sched(pid)
    result_hash = Hash.new
    begin
      File.read("/proc/#{pid}/sched").each_line do |line|
        if line.match /\ :\ /
          s = line.split(":")
          result_hash[s[0].strip] = numeric((s[1].strip.split)[0])
        end
      end
    rescue StandardError => standard_error
      result_hash = { "ERROR" => "#{standard_error}"}
      raise
    end

    result_hash
  end

    def self.key_process
    rhash = Hash.new
    all_pids.each do |pid|
      rhash.merge key_process_pid(pid) if File.exists? "/proc/#{pid}"
    end
    rhash
  end
  
  def self.all_pids
    pids = Array.new
    Dir.entries("/proc/").each do |e|
      pids << e if e.match /^[0-9]+$/
    end
    pids
  end
end
