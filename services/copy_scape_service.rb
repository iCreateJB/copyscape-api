require 'faraday'
require 'yaml'

# Allow one object to send/receive request
class CopyScapeService
  class << self
    def get(data)
      self.new(:get,url,data).send
    end

    def post(data)
      self.new(:post,'/',data).send
    end
  end

  attr_accessor :method, :url, :data, :resp

  def initialize(method,url,data)
    @method = method
    @url    = url
    @data   = data
  end

  def send
    resp = api.send(@method.to_s) do |req|
      req.body = body
    end
    @resp = OpenStruct.new(body: resp.body, code: resp.status)
  end
private
  def api
    Faraday.new(url: config['url'])
  end

  def config
    YAML.load_file('./config/copyscape.yml')[ENV['RACK_ENV']]
  end

  def body
    operation  = data.has_key?(:operation) ? data.delete(:operation) : 'csearch'
    encoding   = data.has_key?(:encoding) ? data.delete(:encoding) : 'UTF-8'
    data.merge!('k' => config['api_key'], 'u' => config['username'], 'e' => encoding, 'o' => operation, 't' => @data['data'])
  end
end
