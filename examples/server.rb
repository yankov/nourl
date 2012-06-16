require 'sinatra'
require '../server/lib/nourl.rb'
# require 'nourl'
require 'user.rb'

post '/rpc' do
  result = Nourl.exec(params)
  result.to_json
end
