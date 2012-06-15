class User
  include Nourl::RPCable

  allow_rpc_for :get

  class << self

    def get(name)
      "User #{name}"
    end

    def write(name)
      "saved a user #{name}"
    end

  end

end