# frozen_string_literal: true

module Vedeu

  # This module provides behaviour for certain classes which can be
  # toggled between being shown and hidden.
  #
  # Currently using this are: {Vedeu::Cursors::Cursor},
  # {Vedeu::Groups::Group} and {Vedeu::Interfaces::Interface}.
  #
  module Toggleable

    # @!attribute [rw] visible
    # @return [Boolean] Whether the toggleable is visible.
    attr_accessor :visible
    alias visible? visible

    # Set the visible state to false and store the model.
    #
    # @return [Boolean]
    def hide
      @visible = false

      store
    end

    # Set the visible state to true and store the model.
    #
    # @return [Boolean]
    def show
      @visible = true

      store
    end

    # Toggle the visible state and store the model. When the model is
    # hidden, then it is shown, and vice versa.
    #
    # @return [Boolean]
    def toggle
      return hide if visible?

      show
    end

    # @macro module_singleton_methods
    module SingletonMethods

      # Hides the named model, or without a name, the model with same
      # name as the currently focussed interface.
      #
      # @example
      #   Vedeu.hide_group(name)
      #   Vedeu.hide_interface(name)
      #
      # @macro param_name
      # @return [void]
      def hide(name = Vedeu.focus)
        repository.by_name(name).hide
      end
      alias hide_group hide
      alias hide_interface hide

      # Shows the named model, or without a name, the model with same
      # name as the currently focussed interface.
      #
      # @example
      #   Vedeu.show_group(name)
      #   Vedeu.show_interface(name)
      #
      # @macro param_name
      # @return [void]
      def show(name = Vedeu.focus)
        repository.by_name(name).show
      end
      alias show_group show
      alias show_interface show

      # Toggles the visibility of the named model, or without a name,
      # the model with same name as the currently focussed interface.
      #
      # @example
      #   Vedeu.toggle_group(name)
      #   Vedeu.toggle_interface(name)
      #
      # @macro param_name
      # @return [void]
      def toggle(name = Vedeu.focus)
        repository.by_name(name).toggle
      end
      alias toggle_group toggle
      alias toggle_interface toggle

      # Hide the cursor if visible.
      #
      # @example
      #   Vedeu.hide_cursor(name)
      #
      # @macro param_name
      # @return [void]
      # @see Vedeu::Toggleable#hide
      def hide_cursor(name = Vedeu.focus)
        hide(name) if cursor_visible?(name)
      end

      # Show the cursor if not already visible.
      #
      # @example
      #   Vedeu.show_cursor(name)
      #
      # @macro param_name
      # @return [void]
      # @see Vedeu::Toggleable#show
      def show_cursor(name = Vedeu.focus)
        show(name) if cursor_visible?(name)
      end

      # Toggle the cursor visibility.
      #
      # @example
      #   Vedeu.toggle_cursor(name)
      #
      # @macro param_name
      # @return [void]
      # @see Vedeu::Toggleable#toggle
      def toggle_cursor(name = Vedeu.focus)
        toggle(name)
      end

      private

      # Returns a boolean indicating whether the cursor is visible.
      #
      # @macro param_name
      # @return [Boolean]
      def cursor_visible?(name)
        buffer(name).cursor_visible?
      end

      # @macro param_name
      # @macro buffer_by_name
      def buffer(name)
        Vedeu.buffers.by_name(name)
      end

    end # SingletonMethods

    # @macro module_included
    def self.included(klass)
      klass.extend(Vedeu::Toggleable::SingletonMethods)
    end

  end # Toggleable

end # Vedeu
