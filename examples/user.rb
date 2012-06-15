class User
  include Nourl::RPCable

  allow_rpc_for :get, :save

  class << self

    def get(name)
      "User #{name}"
    end

    def save(name)
      "saved a user #{name}"
    end

  end

end