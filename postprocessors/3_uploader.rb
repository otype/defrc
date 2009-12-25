#!/usr/bin/env ruby

# Set input logfile if that file exists
INPUT_FILE = ARGV[0] if File.exist(ARGV[0])

# CouchDB information still hardcoded here but easy to change
COUCHDB_HOST = "localhost"
COUCHDB_PORT = "5984"
COUCHD_DATABASE = "defg1test"

# Put together the URL for CouchDB
COUCHDB_URL = "http://#{COUCHDB_HOST}:#{COUCHDB_PORT}/#{COUCHDB_DATABASE}"

# Debug flag for verbose output
DEBUGGING = false

# cUrl command
CURL_POST = "curl -X POST -d"

# Run the upload
file = File.open(INPUT_FILE)
file.each_line do |line|
   couchdb_request = CURL_POST + " \"" + line.strip + "\" " + COUCHDB_URL
   puts couchdb_request if DEBUGGING
   ans = system(couchdb_request)
   puts ans if DEBUGGING
end
file.close
