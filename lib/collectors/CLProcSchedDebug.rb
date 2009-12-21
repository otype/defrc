class CLProcSchedDebug < CollectorModule

  def self.info
    "CLProcSchedDebug delivers scheduler debug information from /proc/sched_debug"
  end

  def self.version
    "0.1"
  end

  def self.category
    "Scheduler"
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

  def self.clean(key)
    key = key.sub(".", "") if key.match /^\./
    key = key.gsub(",", "") if key.match /,/
    key
  end

  private
  
  def self.process
    result_hash = Hash.new
    File.read("/proc/sched_debug").each_line do |line|
      if line.match(":")
        s = line.split(":")  
        result_hash[CLProcSchedDebug.clean(s[0].strip)] = numeric(((CLProcSchedDebug.clean(s[1].strip)).split)[0])
      end
    end
    result_hash
  end

end
