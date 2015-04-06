require 'vedeu/repositories/model'

module Vedeu

  # The Buffer object represents the states of display for an interface. The
  # states are 'front', 'back' and 'previous'.
  #
  class Buffer

    include Vedeu::Model

    # The next buffer to be displayed; contains the content which will be shown
    # on next refresh.
    #
    # @!attribute [rw] back
    # @return [Interface]
    attr_accessor :back

    # The currently displayed buffer, contains the content which was last
    # output.
    #
    # @!attribute [rw] front
    # @return [Interface]
    attr_accessor :front

    # The previous buffer which was displayed; contains the content that was
    # shown before 'front'.
    #
    # @!attribute [rw] previous
    # @return [Interface]
    attr_accessor :previous

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    # Return a new instance of Buffer. Generally a Buffer is initialized with
    # only a 'name' and 'back' parameter.
    #
    # @option attributes name [String] The name of the interface for which the
    #   buffer belongs.
    # @option attributes back [Interface]
    # @option attributes front [Interface]
    # @option attributes previous [Interface]
    # @option attributes repository [Vedeu::Buffers]
    # @return [Buffer]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @name       = @attributes[:name]
      @back       = @attributes[:back]
      @front      = @attributes[:front]
      @previous   = @attributes[:previous]
      @repository = @attributes[:repository] || Vedeu.buffers
    end

    # Add the content to the back buffer, then update the repository. Returns
    # boolean indicating that the repository was updated. Here we also apply any
    # overridden colours or styles in the buffered view to the stored interface.
    #
    # @param content [Interface]
    # @return [Boolean]
    def add(content)
      content.colour = interface.colour unless content.colour
      content.style  = interface.style  unless content.style

      @back = content

      store

      true
    end

    # Return the content for this buffer.
    #
    # - If we have new content (i.e. content on 'back') to be shown, we first
    #   clear the area occupied by the previous content, then clear the area for
    #   the new content, and then finally render the new content.
    # - If there is no new content (i.e. 'back' is empty), check the 'front'
    #   buffer and display that.
    # - If there is no new content, and the front buffer is empty, display the
    #   'previous' buffer.
    # - If the 'previous' buffer is empty, return an empty collection.
    #
    # @return [Array<Hash>]
    def render
      buffer = if content_for?(:back)
        swap

        [front.render]

               elsif content_for?(:front)
        [front.render]

               elsif content_for?(:previous)
        [previous.render]

               else
        []

      end

      Vedeu::Output.render(buffer) unless buffer.empty?

      buffer
    end
    alias_method :content, :render

    # Returns the front buffer or, if that is empty, the interface cleared.
    #
    # @return [void]
    def clear
      buffer = if content_for?(:front)
        front.clear.clear

               else
        interface.clear.clear

      end

      Vedeu::Output.render(buffer) unless buffer.empty?

      buffer
    end

    private

    # @return [Hash<Symbol => NilClass, String>]
    def defaults
      {
        back:     nil,
        front:    nil,
        name:     '',
        previous: nil,
      }
    end

    # Return a boolean indicating content was swapped between buffers.
    #
    # @return [Boolean]
    def swap
      @previous = front
      @front    = back
      @back     = nil

      store

      true
    end

    # Return a boolean indicating content presence on the buffer type.
    #
    # @param buffer [Symbol] One of; :back, :front or :previous.
    # @return [Boolean] Whether the buffer targetted has content.
    def content_for?(buffer)
      return false if public_send(buffer).nil? ||
                      public_send(buffer).content.empty?

      true
    end

    # @return [Vedeu::Interface]
    def interface
      @interface ||= Vedeu.interfaces.find(name)
    end

  end # Buffer

end # Vedeu
