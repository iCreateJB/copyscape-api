require "rubygems"
require "sinatra"

ENV['RACK_ENV'] ||= 'development'

require File.expand_path '../app.rb', __FILE__

# API Version in resource
map '/v1' do
  run IesApi
end
