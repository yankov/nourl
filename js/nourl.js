var nourl = {
  init: function(settings, callback) {
    if (settings.transport == undefined || settings.transport == 'ajax') {
      nourl.Ajax.init(settings);
    } else {
      throw "Doesn't support " + settings.transport;
    }

    callback();
  },

  rpc_id: function() {
    id = typeof(id) != "undefined" ? id : 0;
    return id += 1;
  },

  run: function(settings, callback) {
    
    this.settings = settings;

    this.init(settings, function(){
      nourl.requireList(settings.require, callback)
    });
    
  },

  // function that creates stubs for methods of the required class
  require: function(name, callback) {  
    nourl.rpc_exec(name + '.rpc_white_list', [], function(stub){

      stub = stub || {result:[]};

      obj = {};

      //create stubs for methods
      for(i in stub.result) {
        method = stub.result[i];

        obj[method] = (function(method){
         return function() {      
            params = Array.prototype.slice.call(arguments);

            func = arguments[arguments.length - 1];
          
            nourl.rpc_exec(name + "." + method, params, function(message) {
              func(message);  
            })
           }
        })(method);
      }

      callback(obj);
    });
  },

  // create stubs for an array of classes
  requireList: function(list, callback) {  
    nourl.rpc_exec('nourl.rpc_white_list_for', [list], function(stub){
      stub = stub || {result:[]}

      //create stubs for methods
      for(i in stub.result) {
        methods = stub.result[i];
        for (x in methods) {
          (function(class_name, method) {
            window[i] = window[i] || {}
            window[i][method] = function() {      
                params = Array.prototype.slice.call(arguments);

                if (typeof arguments[arguments.length - 1] === "function") {
                  func = arguments[arguments.length - 1]  
                } else {
                  func = null;
                }

                nourl.rpc_exec(class_name + "." + method, params, function(message) {
                  if (func) func(message);
                });
            }
          
          })(i, methods[x])
        }
      }

      callback();
    });
  },

  // sends json-rpc formatted string to an eventbus through sockjs
  rpc_exec: function(method_name, params, callback) {
    nourl.send(
       nourl.json_rpc_format(method_name, params, nourl.rpc_id()), function(message) {

         if (message.error) throw method_name + ": " + message.error;

         // nourl.Events.trigger(method_name + ":complete", window, message); 
        
         callback(message);
       }
     );
  },

  // formats given arguments in json-rpc format
  json_rpc_format: function(method_name, params, id) {
    return {"method": method_name, "params": params, "id": id};
  }
}


nourl.Ajax = {
  init: function(settings) {
    this.rpcUrl = settings.rpcUrl;
    nourl.send = this.send;
  },

  send: function(message, callback) {
    var client = new XMLHttpRequest();
    client.open('POST', nourl.Ajax.rpcUrl, false);
    client.onreadystatechange = function() {
      callback(client.responseText);
    }

    client.send(null);
  }
}
