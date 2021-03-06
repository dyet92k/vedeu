# frozen_string_literal: true

module Vedeu

  module Output

    module Compressors

      # A simple compressor which does not compress- it converts each
      # buffer object into a string and returns the resulting blob of
      # text.
      #
      # @api private
      #
      class Simple

        # @param (see #initialize)
        # @return (see #compress)
        def self.with(content)
          new(content).compress
        end

        # @param content [Array<void>]
        # @return [Vedeu::Output::Compressors::Simple]
        def initialize(content)
          @content = content
        end

        # @return [String]
        def compress
          Vedeu.timer('Stringifying cells...') do
            content.map(&:to_s).join
          end.tap do |out|
            Vedeu.log(type:    :compress,
                      message: "#{message} -> #{out.size} characters")
          end
        end

        protected

        # @!attribute [r] content
        # @return [void]
        attr_reader :content

        private

        # @return [String]
        def message
          "Compression for #{content.size} objects"
        end

      end # Simple

    end # Compressors

  end # Output

end # Vedeu
