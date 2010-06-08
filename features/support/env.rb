require "lib/islaide"
gem 'rspec'
gem 'capybara'

require 'capybara/cucumber'

include Capybara

MongoRecord::Base.connection = Mongo::Connection.new.db "cucumber"

Capybara.app = Islaide 

set :views,  File.expand_path(File.dirname(__FILE__) + '/../../views')
set :public,  File.expand_path(File.dirname(__FILE__) + '/../../public')
