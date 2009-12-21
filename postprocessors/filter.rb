#!/usr/bin/env ruby

class Filter

	def initialize(source_file)
		@source = source_file
		@shell_filter = "./filter.sh"
	end

	def shell_magic
		puts "[Shell magic]"
		%x{#{@shell_filter} #{@source}}
	end	

end


ARGV.each do|a|
	puts "[Running filter for #{a} ]"
	f = Filter.new(a) if File.exists?(a)
 	f.shell_magic
end
