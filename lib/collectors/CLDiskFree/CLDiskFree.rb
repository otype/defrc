class CLDiskFree

  def self.dfh_to_json
    (Dfh.new).to_json
  end

  def self.dfh_to_csv
    (Dfh.new).to_csv
  end
  
  def self.dfh_header_to_csv
    (Dfh.new).header_to_csv
  end

  def self.dfh_body_to_csv
    (Dfh.new).body_to_csv
  end


  def self.dfk_to_json
    (Dfk.new).to_json
  end
  
  def self.dfk_to_csv
    (Dfk.new).to_csv
  end
    
  def self.dfk_header_to_csv
    (Dfk.new).header_to_csv
  end
  
  def self.dfk_body_to_csv
    (Dfk.new).body_to_csv
  end

  
  def self.df_to_json
    (Df.new).to_json
  end

  def self.df_to_csv
    (Df.new).to_csv
  end

  def self.df_header_to_csv
    (Df.new).header_to_csv
  end

  def self.df_body_to_csv
    (Df.new).body_to_csv
  end

end