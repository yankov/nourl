describe Nourl::RPCable do

  it "should return an array of accessible methods" do
    User.rpc_white_list.should == [:read]
  end

end