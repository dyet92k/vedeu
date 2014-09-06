module Vedeu
  module API

    # Provides a set of helpful API methods to return information about various
    # registered subsystems.
    #
    # @api public
    module Defined

      extend self

      # Returns all events currently registered with Vedeu.
      #
      # @return [Array]
      def events
        Vedeu.events.registered
      end

      # Returns all groups currently registered with Vedeu.
      #
      # @return [Array]
      def groups
        Vedeu::Groups.registered
      end

      # Returns all interfaces currently registered with Vedeu.
      #
      # @return [Array]
      def interfaces
        Vedeu::Interfaces.registered
      end

    end
  end
end
