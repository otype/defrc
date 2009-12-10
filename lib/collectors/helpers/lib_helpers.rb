class Helpers

  def self.clean_array_elements(arr)
    arr.map { |v| v.chomp.strip }
  end

  def self.delete_empty_array_elements(arr)
    (arr.delete_if { |v| v.eql?("") }).delete_if { |v| v.nil? }
  end

  def self.remove_last_comma(line)
    line[-2,1] = "" if line[-2,1] == ","
    line[-1,1] = "" if line[-1,1] == ","
    return line
  end
  
  def self.array_to_csv(arr)
    ans = String.new
    arr.each do |elem|
      elem = Helpers.remove_quotes_from_string(elem)
      ans += elem.join(",") + "\n"
    end
    return ans
  end

  def self.array_to_json(title, arr)
    json = "{ \"#{title}\" : ["
    arr.each do |elem|
      elem = Helpers.remove_quotes_from_string(elem)
      json += " \"#{elem}\", "
    end
    return "#{self.remove_last_comma(json)} ] }"
  end

  def self.skip_lines(arr, num)
    1.upto(num.to_i) { arr.delete(arr.first) }
    return arr
  end

  def self.remove_quotes_from_string(line)
    if line.include?("\"") or line.include?("\'") or line.include?("\`")
      line = line.delete("\"").delete("\'").delete("\`")
    end
    return line
  end

end