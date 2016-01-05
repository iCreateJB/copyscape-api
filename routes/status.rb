class IesApi < Sinatra::Application
  get '/status' do
    @resp = OpenStruct.new( message: "Ok" )
    rabl :'status/status', format: :json
  end
end
