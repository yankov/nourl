Nourl
=====

Nourl is a simple library that allows you to call models' methods on server from
your javascript as if they were local. 

It consists of two parts: a simple ruby JSON-RPC server and javascript client. 
JS client automatically creates stubs for backend classes and methods you want to use and allows you to call
them as if they were defined in javascript.

..What?
-------
So, say, on your backend side you have a model `User` with the method `get`.

    class User
      def self.get(name)
        User.find_by_name(name)
      end
    end

Now, from my client JS you want to be able to call user.get without making any API calls,
creating controllers and dealing with RPC manually. It works just like this:

    user.get("John", function(result) {
      console.log(result);
    })

That's it.

How to use it
-------------

`gem install nourl`  
`git clone https://github.com/yankov/nourl.git`

Then you can run an example server.rb from example folder:

`cd ./nourl/examples`  
`ruby -rubygems server.rb`

To use server.rb from examples you may need to install sinatra first: `gem install sinatra`, but 
it's easy to build your own server. You just have to have a /rpc endpoint, pass parameters to to Nourl.exec
and respond with the json string.

You can include your classes that you want to provide RPC access to in server.rb.  
Then include Nourl::RPCable in your class and list methods that allowed for remote calls.

    class User
      include Nourl::RPCable
    
      allow_rpc_for :create, :destroy
      ...
    end

Then in your JS application.

    <script type="text/javascript">
    
      var settings = {
        rpcUrl: "http://0.0.0.0:4567/rpc", //host and port where your server is running
        transport: "ajax",
        require: ["user"]                 // list all classes that you wanna access to
      }
    
      nourl.run(settings, function(){
    
         user.get('john', function(result) {
            console.log(result);
         });
        
      }); 
    
    </script>






