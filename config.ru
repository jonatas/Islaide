require "lib/islaide"
require 'uri'

if ENV['MONGOHQ_URL']
  uri = URI.parse(ENV['MONGOHQ_URL'])
  conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
  db = conn.db(uri.path.gsub(/^\//, ''))
else
  db = Mongo::Connection.new.db 'islaide'
end

MongoRecord::Base.connection = db
 #Mongo::Connection.new(ENV['MONGOHQ_URL']).db "islaide"

run Islaide

