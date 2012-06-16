module Nourl

  class << self
    def rpc_white_list_for(class_list)
      class_list = [class_list] unless class_list.is_a?(Array)

      class_list.inject({}) do |list, class_name|
        klass = Object.const_get(class_name.capitalize)

        list[class_name] = klass.send(:rpc_white_list)
        list
      end
    end

    def can_call?(klass, method)
      return true if klass == Nourl && method == 'rpc_white_list_for'
      return true if klass.send(:rpc_white_list).include?(method.to_sym)
      false
    end

    def exec(params)
      rpc_string = JSON.parse(params['rpc_string'])
      class_name, method = rpc_string['method'].split(".")
      klass = Object.const_get(class_name.capitalize)
    
      params = rpc_string['params']

      raise "No access to call #{klass.to_s}.#{method}." unless Nourl.can_call?(klass, method)

      #TODO: find a sexy way to do this 
      result = if params.is_a?(Array)
        klass.send(method, *params.compact)
      else
        klass.send(method, params)
      end

      json_rpc_format(result, nil, rpc_string['id'])
    rescue => e
      json_rpc_format(nil, e.message, rpc_string['id'])
    end

    def json_rpc_format(result, error, id)
      { "result" => result, "error" => error, "id" => id }
    end

  end 

end
