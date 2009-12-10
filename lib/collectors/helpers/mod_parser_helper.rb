module ParserHelper
  def run_splitter
    @headerexists ? split_header_and_body : split_body
  end

  def override_header(newheader)
    @header = newheader
    @headerexists = false
    @skiplines = 1
  end

  def header_exists(headerexists)
    @headerexists = headerexists
  end

  def skip_header_lines(skiplines)
    @skiplines = skiplines
  end

  def is_a_file(param)
    @usefile = param
  end

  def body_to_csv
    Helpers.array_to_csv(@body)
  end

  def header_to_csv
    @header.join(",")
  end

  def to_json
    array_to_json(@body)
  end

  private

  #
  # A given line with number of elements will be stripped
  # down or filled up with elements to be of same size
  # as the header
  #
  def align_body_columns_to_header_column(line)
    lsize = line.size

    if lsize > @header_columns
      difference = lsize - @header_columns
      rest = Array.new
      (difference + 1).times { rest << line.pop }
      line << rest.reverse.join(" ")
    end

    if lsize < @header_columns
      lsize.upto(@header_columns-1) { line << nil }
    end

    return line
  end
end