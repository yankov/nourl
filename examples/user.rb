class User
  include Nourl::RPCable

  allow_rpc_for :get

  def get(name)
    "User #{name}"
  end

end