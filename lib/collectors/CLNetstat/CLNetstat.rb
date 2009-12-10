class CLNetstat

  def self.netstatrn_to_json
    (NetstatRN.new).to_json
  end

  def self.netstatrn_to_csv
    (NetstatRN.new).to_csv
  end
  
  def self.netstatrn_header_to_csv
    (NetstatRN.new).header_to_csv
  end

  def self.netstatrn_body_to_csv
    (NetstatRN.new).body_to_csv
  end

end