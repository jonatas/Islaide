require "lib/islaide"

MongoRecord::Base.connection = Mongo::Connection.new(ENV['MONGOHQ_URL']).db "islaide"

run Islaide

