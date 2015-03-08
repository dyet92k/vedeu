require 'vedeu/output/esc'

module Vedeu

  # Represents the concept of a visible or invisible attribute.
  #
  class Visible

    # @param value [Boolean|Symbol]
    # @return [Visible]
    def self.coerce(value)
      if value.is_a?(self)
        value

      else
        new(value)

      end
    end

    # @param visible [Boolean|Symbol]
    # @return [Visible]
    def initialize(visible = nil)
      @visible = if visible == :hide || visible == false
        false

      elsif visible == :show || visible == true
        true

      else
        !!visible

      end
    end

    # @return [String]
    def cursor
      if visible?
        Vedeu::Esc.string('show_cursor')

      else
        Vedeu::Esc.string('hide_cursor')

      end
    end

    # @return [Boolean]
    def visible?
      @visible
    end

    # @return [Boolean]
    def invisible?
      !@visible
    end

    # @return [Visible]
    def hide
      Vedeu::Visible.new(false)
    end

    # @return [Visible]
    def show
      Vedeu::Visible.new(true)
    end

    # @return [Visible]
    def toggle
      visible? ? hide : show
    end

  end # Visible

end # Vedeu
