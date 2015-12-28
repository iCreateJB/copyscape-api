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

class IesApi < Sinatra::Application
  def parse_params
    if @env["CONTENT_TYPE"] == 'application/json'
      rack_input = @env["rack.input"].read
      @env["rack.input"].rewind
      return if rack_input.empty?
      begin
        body_content = HashWithIndifferentAccess.new(JSON.parse(URI.decode(rack_input)))
      rescue JSON::ParserError
        halt render :json, { status: 400, error: 'Invalid Request'}
      end
      @params.merge!(body_content)
      @env["rack.request.form_hash"] = body_content
    end
  end
end
