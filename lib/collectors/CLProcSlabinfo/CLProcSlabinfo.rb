class CLProcSlabinfo

  def self.to_json
    (ProcSlabinfo.new).to_json
  end

  def self.to_csv
    (ProcSlabinfo.new).to_csv
  end
  
  def self.header_to_csv
    (ProcSlabinfo.new).header_to_csv
  end

  def self.body_to_csv
    (ProcSlabinfo.new).body_to_csv
  end
end