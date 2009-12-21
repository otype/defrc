#!/usr/bin/env ruby1.9


#logfile = File.open("logfile.log", "w+")
file = File.open(ARGV[0])

file.each_line do |line|
   cmd = "curl -X POST -d"
   url = "http://localhost:5984/defg1test/"
   whole_command = cmd + " \"" + line.strip + "\" " + url
   # puts whole_command
   ans = system(whole_command)

end

file.close
#logfile.close
