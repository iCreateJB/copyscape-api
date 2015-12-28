class IesApi < Sinatra::Application
  post '/text-search' do
    parse_params
    req     = Request::TextSearch.new(params)
    @search = if req.valid?
      Response::TextSearch.new(TextSearchService.create(req)).parse
    else
      OpenStruct.new(error: req.errors.collect{|k,v| v }, code: 400, total_count: 0, entries: [])
    end
    rabl :'text_search/text_search', format: :json
  end
end
