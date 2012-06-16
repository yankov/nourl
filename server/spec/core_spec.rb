describe Nourl do 
  
  describe Nourl, ".rpc_white_list_for" do

    it "should return a list of accessible methods" do
      Nourl.rpc_white_list_for("User").should == {"User" => [:read]}
    end
  
    it "should handle array of classes" do
      Nourl.rpc_white_list_for(["User", "Post"]).should == 
        {"User" => [:read],
         "Post" => [:create, :edit]}
    end
  end

  describe Nourl, ".can_call?" do

    it "should return TRUE for allowed methods" do
      Nourl.can_call?(User, "read")  
    end

    it "should return FALSE for not-allowed methods " do
      Nourl.can_call?(User, "edit")  
    end

  end

  describe Nourl, ".exec" do

    it "should call a passed method" do
      rpc_string = {"rpc_string" => {"method" => "User.read", "params" => ["John"]}.to_json}
      Nourl.exec(rpc_string).should == {"result"=>"user John", "error"=>nil, "id"=>nil}
    end

    it "should handle errors" do
      rpc_string = {"rpc_string" => {"method" => "User.read", "params" => ["John", 2]}.to_json}
      Nourl.exec(rpc_string).should == {"result"=>nil, "error"=>"wrong number of arguments (2 for 1)", "id"=>nil}
    end

    it "should handle not-allowed calls" do
      rpc_string = {"rpc_string" => {"method" => "User.edit", "params" => ["John"]}.to_json}
      Nourl.exec(rpc_string).should == {"result"=>nil, "error"=>"No access to call User.edit.", "id"=>nil}
    end

  end

  describe Nourl, ".json_rpc_format" do

    it "return a JSON-RPC formatted string" do
      Nourl.json_rpc_format("some_result", nil, 3).should == {"result" => "some_result", "error" => nil, "id" => 3}
    end
    
  end

  
end