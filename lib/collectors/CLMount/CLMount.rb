class CLMount

  def self.mount_to_json
    (Mount.new).to_json
  end

  def self.mount_to_csv
    (Mount.new).to_csv
  end
  
  def self.mount_header_to_csv
    (Mount.new).header_to_csv
  end

  def self.mount_body_to_csv
    (Mount.new).body_to_csv
  end

end