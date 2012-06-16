$:.unshift File.expand_path('../lib', File.dirname(__FILE__))

require "nourl"

#mocks
class User
  include Nourl::RPCable

  allow_rpc_for :read

  class << self
    def read(name); "user #{name}" end;
    def edit; true; end;
  end
end

class Post
  include Nourl::RPCable

  allow_rpc_for :create, :edit  

  class << self
    def read; true; end;
    def edit; true; end;
    def destroy; true; end;
  end
end