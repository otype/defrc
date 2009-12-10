def readfile(src)
	dest = "/cache/#{src}"
	s = File.open(src, "r")
	d = File.new(dest, "w")
	d.puts(s.readlines)
	s.close
	d.close
end

src = ARGV[0]
#dst = ARGV[1]

readfile(src) if not File.directory?(src)
