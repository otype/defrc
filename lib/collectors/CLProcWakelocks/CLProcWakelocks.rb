class CLProcWakelocks

  def self.to_json
    (ProcWakelocks.new).to_json
  end

  def self.to_csv
    (ProcWakelocks.new).to_csv
  end
  
  def self.header_to_csv
    (ProcWakelocks.new).header_to_csv
  end

  def self.body_to_csv
    (ProcWakelocks.new).body_to_csv
  end
end