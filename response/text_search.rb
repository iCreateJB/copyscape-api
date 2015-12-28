require 'nori'

module Response
  class TextSearch
    attr_accessor :data

    def initialize(data)
      @data = data
    end

    # Response is XML
    # Error response also return 200
    def parse
        response = Nori.new.parse(@data.body)
        if !response['response'].has_key?('error')
          OpenStruct.new(
            code: @data.code,
            count: response['response']['count'].to_i,
            entries: results(response['response']['result'])
          )
        else
          # Indicate a valid status ( Request completed but you did something wrong )
          OpenStruct.new(
            code: 400,
            count: 0,
            entries: [],
            message: response['response']['error']
          )
        end
    end
  private
    def results(response)
      results = []
      response.map{|i| results.push(entry(i)) }
      results
    end

    def entry(data)
      OpenStruct.new(
        index: data['index'],
        url: data['url'],
        title: data['title'],
        html_snippet: data['htmlsnippet'],
        text_snippet: data['textsnippet'],
        view_url: data['viewurl']
      )
    end
  end
end
