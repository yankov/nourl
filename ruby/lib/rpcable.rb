module Nourl
  module RPCable

    def self.included(base)
      base.extend(ClassMethods)
    end
  
    module ClassMethods
      attr_reader :rpc_white_list

      private

      def allow_rpc_for(*methods)
        @rpc_white_list ||= []
        @rpc_white_list |= methods
      end
    end

  end
end
