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

Now, from my client JS I want to be able to call user.get without making any API calls,
creating controllers and dealing with RPC manually. I works just like this:

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






