require 'vedeu/support/common'

module Vedeu

  module DSL

    # DSL for creating interfaces.
    #
    class Interface

      include Vedeu::Common
      include Vedeu::DSL
      include Vedeu::DSL::Colour
      include Vedeu::DSL::Style
      include Vedeu::DSL::Text
      include Vedeu::DSL::Use

      # Returns an instance of DSL::Interface.
      #
      # @param model [Interface]
      # @param client [Object]
      # @return [Vedeu::DSL::Interface]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Allows the setting of a border for the interface.
      #
      # @param block [Proc]
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Hash]
      def border(&block)
        fail InvalidSyntax, 'block not given' unless block_given?

        attributes = { client: @client, enabled: true, interface: model }

        model.border = Vedeu::Border.build(attributes, &block)
      end

      # Set the cursor visibility on an interface.
      #
      # @param value [Boolean] Any value other than nil or false will evaluate
      #   to true.
      #
      # @example
      #   interface 'my_interface' do
      #     cursor  true  # => show the cursor for this interface
      #     cursor  :show # => both of these are equivalent to line above
      #     cursor!       #
      #     ...
      #
      #     cursor false # => hide the cursor for this interface
      #     cursor :hide # => both of these are equivalent to line above
      #     cursor nil   #
      #     ...
      #
      #   view 'my_interface' do
      #     cursor true
      #     ...
      #
      # @return [Symbol]
      def cursor(value = true)
        Vedeu::Cursor.new({ name: model.name, state: value }).store
      end

      def cursor!
        cursor(true)
      end

      # To maintain performance interfaces can be delayed from refreshing too
      # often, the reduces artefacts particularly when resizing the terminal
      # screen.
      #
      # @param value [Fixnum|Float]
      #
      # @example
      #   interface 'my_interface' do
      #     delay 0.5 # interface will not update more often than every 500ms.
      #     ...
      #
      # @return [Fixnum|Float]
      def delay(value)
        model.delay = value
      end

      # Specify this interface as being in focus when the application starts.
      #
      # @note If multiple interfaces are defined, and this is included in each,
      #   then the last defined will be the interface in focus.
      #
      # @return [String] The name of the interface in focus.
      def focus!
        Vedeu::Focus.add(model.name, true) if defined_value?(model.name)
      end

      # Define the geometry for an interface.
      #
      # @param block [Proc]
      #
      # @example
      #   interface 'my_interface' do
      #     geometry do
      #       ...
      #
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Geometry]
      # @see Vedeu::DSL::Geometry
      def geometry(&block)
        fail InvalidSyntax, 'block not given' unless block_given?

        model.geometry = Vedeu::Geometry.build({ client: @client }, &block)
      end

      # Specify a group for an interface. Interfaces of the same group can be
      # targetted together; for example you may want to refresh multiple
      # interfaces at once.
      #
      # @param value [String] The name for the group of interfaces.
      #
      # @example
      #   interface 'my_interface' do
      #     group 'main_screen'
      #     ...
      #
      # @return [String]
      def group(value)
        if defined_value?(model.name)
          if Vedeu.groups.registered?(value)
            Vedeu.groups.find(value).add(model.name)

          else
            Vedeu::Group.new(value, model.name).store

          end
        end

        model.group = value
      end

      # @see Vedeu::Keymap#keymap
      def keymap(name = model.name, &block)
        Vedeu.keymap(name, &block)
      end
      alias_method :keys, :keymap

      # Specify multiple lines in a view.
      #
      # @param block [Proc]
      #
      # @example
      #   view 'my_interface' do
      #     lines do
      #       ... see {DSL::Line} and {DSL::Stream}
      #     end
      #   end
      #
      #   view 'my_interface' do
      #     line do
      #       ... see {DSL::Line} and {DSL::Stream}
      #     end
      #   end
      #
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Line]
      def lines(&block)
        unless block_given?
          fail InvalidSyntax, "'#{__callee__}' requires a block."
        end

        attributes = { client: @client, streams: [], parent: model }

        model.lines.add(Vedeu::Line.build(attributes, &block))
      end

      # The name of the interface. Used to reference the interface throughout
      # your application's execution lifetime.
      #
      # @param value [String]
      #
      # @example
      #   interface do
      #     name 'my_interface'
      #     ...
      #
      # @return [String]
      def name(value)
        model.name = value
      end


      private

      attr_reader :client, :model

      def child
        Vedeu::Line
      end

      def attributes
        {
          client: client,
          parent: model,
        }
      end

    end # Interface

  end # DSL

end # Vedeu
