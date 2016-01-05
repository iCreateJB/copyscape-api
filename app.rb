require 'sinatra'
require 'json'
require 'pry'
require 'rabl'
require 'active_support/all'

require_relative 'routes/init'
require_relative 'request/init'
require_relative 'response/init'
require_relative 'services/init'

Rabl.configure do |config|
  config.include_json_root = false
  config.include_child_root = false
end

Rabl.register!

before do
  unless request.media_type == 'application/json'
    halt 415, { error: 'Unsupported media type' }.to_json
  end
end

after do
  response.headers['Content-Type'] = 'application/json'
end

class IesApi < Sinatra::Application
  def parse_params
    rack_input = @env["rack.input"].read
    @env["rack.input"].rewind
    return if rack_input.empty?
    begin
      body_content = HashWithIndifferentAccess.new(JSON.parse(URI.decode(rack_input)))
    rescue JSON::ParserError
      halt 400, { error: 'Invalid Request' }.to_json
    end
    @params.merge!(body_content)
    @env["rack.request.form_hash"] = body_content
  end
end
