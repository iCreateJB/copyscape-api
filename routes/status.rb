class IesApi < Sinatra::Application
  get '/status' do
    @resp = OpenStruct.new( code: 200 )
    rabl :status, format: :json
  end
end
