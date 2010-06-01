require "rubygems"
gem "maruku"
gem "sinatra"
gem 'rspec'
gem 'capybara'

require "maruku"
require "sinatra"
require "lib/islaide"
require 'capybara/cucumber'

include Capybara

Capybara.app = Islaide 

set :views,  File.expand_path(File.dirname(__FILE__) + '/../../views')
set :public,  File.expand_path(File.dirname(__FILE__) + '/../../public')
