class CLProcessList  
  def self.ps_to_json
    (Ps.new).to_json
  end

  def self.ps_to_csv
    (Ps.new).to_csv
  end

  def self.ps_header_to_csv
    (Ps.new).header_to_csv
  end

  def self.ps_body_to_csv
    (Ps.new).body_to_csv
  end

  
  def self.psef_to_json
    (Psef.new).to_json
  end

  def self.psef_to_csv
    (Psef.new).to_csv
  end
  
  def self.psef_header_to_csv
    (Psef.new).header_to_csv
  end

  def self.psef_body_to_csv
    (Psef.new).body_to_csv
  end


  def self.psaux_to_json
    (Psaux.new).to_json
  end
  
  def self.psaux_to_csv
    (Psaux.new).to_csv
  end
    
  def self.psaux_header_to_csv
    (Psaux.new).header_to_csv
  end
  
  def self.psaux_body_to_csv
    (Psaux.new).body_to_csv
  end

end
