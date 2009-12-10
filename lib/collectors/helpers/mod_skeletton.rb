module ModSkeletton
  def to_csv
    @collector.header_to_csv + "\n" + @collector.body_to_csv
  end
  
  def header_to_csv
    @collector.header_to_csv
  end

  def body_to_csv 
    @collector.body_to_csv
  end

  def to_json
    @collector.to_json
  end
end



