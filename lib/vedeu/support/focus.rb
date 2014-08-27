module Vedeu
  NoInterfacesDefined = Class.new(StandardError)
  InterfaceNotFound   = Class.new(StandardError)

  # Maintains which interface is current in focus.
  class Focus

    def initialize
      register_events

      self
    end

    def add(name)
      if registered?(name)
        storage

      else
        storage << name

      end
    end

    def by_name(name)
      fail InterfaceNotFound unless storage.include?(name)

      storage.rotate!(storage.index(name))

      current
    end

    def current
      fail NoInterfacesDefined if storage.empty?

      storage.first
    end

    def next_item
      storage.rotate!

      current
    end

    def prev_item
      storage.rotate!(-1)

      current
    end

    def register_events
      Vedeu.event(:_focus_next_)    { next_item }
      Vedeu.event(:_focus_prev_)    { prev_item }
      Vedeu.event(:_focus_by_name_) { |name| by_name(name) }
    end

    private

    def registered?(name)
      return false if storage.empty?

      storage.include?(name)
    end

    def storage
      @storage ||= []
    end

  end
end