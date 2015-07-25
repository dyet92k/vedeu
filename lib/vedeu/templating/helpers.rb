module Vedeu

  # Provides means to use templates with Vedeu.
  module Templating

    # Provide helpers to be used with your Vedeu templates.
    #
    module Helpers

      # @param value [String] The HTML/CSS colour.
      # @param block [Proc]
      # @return [Vedeu::Stream]
      # @raise [Vedeu::InvalidSyntax] The required block was not given.
      def background(value, &block)
        define_stream({ background: value }, &block)
      end
      alias_method :bg, :background

      # @param attributes [Hash]
      # @option attributes foreground [String] The HTML/CSS foreground colour.
      # @option attributes background [String] The HTML/CSS background colour.
      # @param block [Proc]
      # @return [Vedeu::Stream]
      # @raise [Vedeu::InvalidSyntax] The required block was not given.
      def colour(attributes = {}, &block)
        define_stream(attributes, &block)
      end

      # @param value [String] The HTML/CSS colour.
      # @param block [Proc]
      # @return [Vedeu::Stream]
      # @raise [Vedeu::InvalidSyntax] The required block was not given.
      def foreground(value, &block)
        define_stream({ foreground: value }, &block)
      end
      alias_method :fg, :foreground

      # @param value [Symbol]
      # @param block [Proc]
      # @return [Vedeu::Stream]
      def style(value, &block)
        define_stream({ style: value }, &block)
      end

      private

      # @see Vedeu::Templating::Helpers#colour
      def define_stream(attributes = {}, &block)
        fail Vedeu::InvalidSyntax, 'block not given' unless block_given?

        Vedeu::Stream.build(colour: Vedeu::Colour.new(attributes),
                            style:  Vedeu::Style.new(attributes[:style]),
                            value:  block.call)
      end

    end # Helpers

  end # Templating

end # Vedeu
