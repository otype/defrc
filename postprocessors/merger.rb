#!/usr/bin/env ruby1.9

require 'json'

# ############################
# FUNCTIONS
# ############################

def validate_params(params_hash)
	if params_hash.size < 1
		puts "Missing parameter!"
		exit 1
	end

	unless File.exists? params_hash[0]
		puts "File #{params_hash[0]} does not exist"
		exit 1
	end

	params_hash
end

def line_to_hash(line)
	line = line.gsub("nil","\"\"")
	return JSON.parse(line) unless line[1,1] == "="
end

def read_file_into_array_hash(sourcefile)
  sourcefile = File.read(SOURCEFILE)
  mhash = Hash.new
  arr = Array.new
  sourcefile.each_line do |line|
    if line.match /^==/
      arr << mhash
      mhash = Hash.new
    end

    mhash = mhash.merge(line_to_hash line) unless line.match /^==/
  end
  arr << mhash
  arr
end


# ############################
# MAIN
# ############################

# Valid script parameters?
PARAMS = validate_params ARGV
SOURCEFILE = PARAMS[0]
DESTFILE = PARAMS[1]

arr = read_file_into_array_hash(SOURCEFILE)

if PARAMS.size == 2
  destfile = File.new("newfile", File::CREAT|File::TRUNC|File::RDWR, 0644)
  arr.each do |elem|
    destfile.puts elem.inspect.gsub("=>",":")
  end
else
  arr.each do |elem|
    puts elem.inspect.gsub("=>",":")
  end
end

# Clean exit
exit 0
