class CollectorModule

  def self.debug
    "INFO : " + info + "\n" +
    "VERSION : " + version + "\n" +
    "CATEGORY : " + category + "\n" +
    "PARAMS : " + params + "\n" +
    "WEIGHT : " + weight + "\n" +
    "PTYPE : " + ptype + "\n" +
    "RUN_DATE : " + "#{formatted_time}\n" +
    "RUN : " + run + "\n\n"
  end

  def self.run
    "{}"
  end

  def self.wait_and_run
    sleep $COLLECTOR_INTERVALS
    run
  end
  
  def self.log_error(msg)
    File.open($ERRORLOG, "a+") { |f|
      f.puts "#{Time.new}:"
      f.puts msg
      f.puts "=============================================\n"
    }
  end

  def self.formatted_time
    t = Time.now
    t.strftime("%Y%m%d%H%M%S")
  end

  def self.numeric(object)
    (Float(object)).prettify if Float(object) rescue object
  end
end