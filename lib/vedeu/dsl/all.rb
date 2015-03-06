require 'vedeu/dsl/components/all'
require 'vedeu/dsl/shared/all'

require 'vedeu/dsl/composition'
require 'vedeu/dsl/group'
require 'vedeu/dsl/interface'
require 'vedeu/dsl/line'
require 'vedeu/dsl/stream'
require 'vedeu/dsl/view'

module Vedeu

  # Provides a mechanism to help configure and use Vedeu.
  #
  module DSL

    private

    # Attempts to find the missing method on the client object.
    #
    # @param method [Symbol] The name of the method sought.
    # @param args [Array] The arguments which the method was to be invoked with.
    # @param block [Proc] The optional block provided to the method.
    # @return [void]
    def method_missing(method, *args, &block)
      Vedeu.log(type: :debug, message: "!!!method_missing '#{method}'")

      client.send(method, *args, &block) if client
    end

  end # DSL

end # Vedeu
