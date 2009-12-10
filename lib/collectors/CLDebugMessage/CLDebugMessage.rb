class CLDebugMessage

  def self.dmesg_to_json
    (Dmesg.new).to_json
  end

  def self.dmesg_to_csv
    (Dmesg.new).to_csv
  end

end