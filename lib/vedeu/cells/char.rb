# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of a
    # with a custom value, colour and style.
    #
    # The Vedeu::Cells::Char object represents an alpha-numeric
    # character.
    #
    # @api private
    #
    class Char < Vedeu::Cells::Empty

      # @return [String]
      def as_html
        return value if present?(value)

        super
      end

      # @return [String]
      def text
        @value || ' '
      end

      # @return [Symbol]
      def type
        :char
      end

    end # Char

  end # Cells

end # Vedeu
