module Vedeu
  EntityNotFound = Class.new(StandardError)

  module API
    def use(name)
      Vedeu::Interface.new(Store.query(name))
    end

    module Store
      extend self

      def create(attributes)
        storage.store(attributes[:name], attributes)
      end

      def query(name)
        storage.fetch(name) { fail EntityNotFound, 'Interface was not found.' }
      end

      def reset
        @storage = {}
      end

      private

      def storage
        @storage ||= {}
      end
    end
  end
end