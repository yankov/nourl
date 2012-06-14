require 'sinatra'
require '../ruby/nourl.rb'
require 'user.rb'

post '/rpc' do
  rpc_string = JSON.parse(params['rpc_string'])
  result = Nourl.proccess(rpc_string)
  result.to_json
end