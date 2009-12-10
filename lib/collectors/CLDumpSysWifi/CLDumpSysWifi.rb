class CLDumpSysWifi  
  def self.dumpsys_wifi_to_json
    (DumpSysWifi.new).to_json
  end

  def self.dumpsys_wifi_to_csv
    (DumpSysWifi.new).to_csv
  end

  def self.dumpsys_wifi_header_to_csv
    (DumpSysWifi.new).header_to_csv
  end

  def self.dumpsys_wifi_body_to_csv
    (DumpSysWifi.new).body_to_csv
  end
  
end
