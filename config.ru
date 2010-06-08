require "lib/islaide"

MongoRecord::Base.connection = Mongo::Connection.new.db "islaide"

run Islaide

