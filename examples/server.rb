require 'sinatra'
require '../server/lib/nourl.rb'
require 'user.rb'

post '/rpc' do
  result = Nourl.proccess(params)
  result.to_json
end
