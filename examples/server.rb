require 'sinatra'
require '../ruby/nourl.rb'
require 'user.rb'

post '/rpc' do
  # Nourl.proccess(params)
  "#{params.inspect}"
end