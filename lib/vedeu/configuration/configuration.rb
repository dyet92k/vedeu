# frozen_string_literal: true

module Vedeu

  # Allows the customisation of Vedeu's behaviour through the
  # configuration API.
  #
  # Provides access to Vedeu's configuration, which was set with
  # sensible defaults (influenced by environment variables),
  # overridden by client application settings (via the configuration
  # API).
  #
  class Configuration

    include Singleton

    class << self

      # Return the configured background colour for the client
      # application.
      #
      # @return [String|Symbol]
      def background
        instance.options[:background]
      end

      # Returns the base_path value.
      #
      # @return [String]
      def base_path
        instance.options[:base_path]
      end

      # Returns the compression value.
      #
      # @return [Boolean]
      def compression
        instance.options[:compression]
      end
      alias_method :compression?, :compression

      # {include:file:docs/dsl/by_method/configure.md}
      # @param opts [Hash<Symbol => void>]
      # @option opts stdin [File|IO]
      # @option opts stdout [File|IO]
      # @option opts stderr [File|IO]
      # @param block [Proc]
      # @raise [Vedeu::Error::InvalidSyntax]
      #   When the required block is not given.
      # @return [Hash<Symbol => void>]
      def configure(opts = {}, &block)
        instance.configure(opts, &block)
      end

      # {include:file:docs/dsl/by_method/configuration.md}
      # @return [Vedeu::Configuration]
      def configuration
        instance
      end

      # @return [Hash]
      def colour
        {
          background: background,
          foreground: foreground,
        }
      end

      # Returns the chosen colour mode.
      #
      # @return [Fixnum]
      def colour_mode
        instance.options[:colour_mode]
      end

      # Returns whether debugging is enabled or disabled. Default is
      # false; meaning only the top line of a backtrace from an
      # exception is shown to the user of the client application.
      #
      # @return [Boolean]
      def debug?
        instance.options[:debug]
      end
      alias_method :debug, :debug?

      # Returns whether the DRb server is enabled or disabled. Default
      # is false.
      #
      # @return [Boolean]
      def drb?
        instance.options[:drb]
      end
      alias_method :drb, :drb?

      # Returns the hostname for the DRb server.
      #
      # @return [String]
      def drb_host
        instance.options[:drb_host]
      end

      # Returns the port for the DRb server.
      #
      # @return [String]
      def drb_port
        instance.options[:drb_port]
      end

      # Returns the height for the fake terminal in the DRb server.
      #
      # @return [Fixnum]
      def drb_height
        instance.options[:drb_height]
      end

      # Returns the width for the fake terminal in the DRb server.
      #
      # @return [Fixnum]
      def drb_width
        instance.options[:drb_width]
      end

      # Return the configured foreground colour for the client
      # application.
      #
      # @return [String|Symbol]
      def foreground
        instance.options[:foreground]
      end

      # Returns the client defined height for the terminal.
      #
      # @return [Fixnum]
      def height
        instance.options[:height]
      end

      # Returns whether the application is interactive (required user
      # input) or standalone (will run until terminates of natural
      # causes.) Default is true; meaning the application will require
      # user input.
      #
      # @return [Boolean]
      def interactive?
        instance.options[:interactive]
      end
      alias_method :interactive, :interactive?

      # Returns the path to the log file.
      #
      # @return [String]
      def log
        instance.options[:log]
      end

      # Returns a boolean indicating whether the log has been
      # configured.
      #
      # @return [Boolean]
      def log?
        log != nil
      end

      # @return [Array<Symbol>]
      def log_except
        instance.options[:log_except] || []
      end

      # @return [Array<Symbol>]
      def log_only
        instance.options[:log_only] || []
      end

      # Returns true if the given type was included in the :log_only
      # configuration option or not included in the :log_except
      # option.
      #
      # @param type [Symbol]
      # @return [Boolean]
      def loggable?(type)
        Vedeu::Configuration.log_only.include?(type) ||
        !Vedeu::Configuration.log_except.include?(type)
      end

      # Returns whether mouse support was enabled or disabled.
      #
      # @return [Boolean]
      def mouse?
        instance.options[:mouse]
      end
      alias_method :mouse, :mouse?

      # Returns whether the application will run through its main loop
      # once or not. Default is false; meaning the application will
      # loop forever or until terminated by the user.
      #
      # @return [Boolean]
      def once?
        instance.options[:once]
      end
      alias_method :once, :once?

      # Returns a boolean indicating whether profiling has been
      # enabled.
      #
      # @return [Boolean]
      def profile?
        instance.options[:profile]
      end
      alias_method :profile, :profile?

      # Returns the renderers which should receive output.
      #
      # @return [Array<Class>]
      def renderers
        instance.options[:renderers]
      end

      # Returns the root of the client application. Vedeu will execute
      # this controller first.
      #
      # @return [Class]
      def root
        instance.options[:root]
      end

      # Returns the redefined setting for STDIN.
      #
      # @return [File|IO]
      def stdin
        instance.options[:stdin]
      end

      # Returns the redefined setting for STDOUT.
      #
      # @return [File|IO]
      def stdout
        instance.options[:stdout]
      end

      # Returns the redefined setting for STDERR.
      #
      # @return [File|IO]
      def stderr
        instance.options[:stderr]
      end

      # Returns the terminal mode for the application. Default is
      # `:raw`.
      #
      # @return [Symbol]
      def terminal_mode
        instance.options[:terminal_mode]
      end

      # Returns the client defined width for the terminal.
      #
      # @return [Fixnum]
      def width
        instance.options[:width]
      end

      # @param value [void]
      # @return [void]
      def options=(value)
        instance.options = value
      end

      # Reset the configuration to the default values.
      #
      # @return [Hash<Symbol => void>]
      def reset!
        instance.reset!
      end

    end # Eigenclass

    # @!attribute [r] options
    # @return [Hash<Symbol => void>]
    attr_reader :options

    # Create a new singleton instance of Vedeu::Configuration.
    #
    # @return [Vedeu::Configuration]
    def initialize
      @options = defaults
    end

    # Set up default configuration and then allow the client
    # application to modify it via the configuration API.
    #
    # @param block [Proc]
    # @return [Hash<Symbol => void>]
    def configure(opts = {}, &block)
      @options.merge!(opts)

      @options.merge!(Config::API.configure(&block)) if block_given?

      Vedeu::Configuration
    end

    # Reset the configuration to the default values.
    #
    # @return [Hash<Symbol => void>]
    def reset!
      @options = defaults
    end

    private

    # The Vedeu default options, which of course are influenced by
    # environment variables also.
    #
    # @return [Hash<Symbol => void>]
    def defaults
      {
        background:    :default,
        base_path:     base_path,
        colour_mode:   detect_colour_mode,
        compression:   true,
        debug:         false,
        drb:           false,
        drb_host:      nil,
        drb_port:      nil,
        drb_height:    25,
        drb_width:     80,
        foreground:    :default,
        height:        nil,
        interactive:   true,
        log:           nil,
        log_except:    [],
        log_only:      [],
        mouse:         true,
        once:          false,
        profile:       false,
        renderers:     [],
        root:          nil,
        stdin:         nil,
        stdout:        nil,
        stderr:        nil,
        terminal_mode: :raw,
        width:         nil,
      }
    end

    # Attempt to determine the terminal colour mode via $TERM
    # environment variable, or be optimistic and settle for 256
    # colours.
    #
    # @return [Fixnum]
    def detect_colour_mode
      case ENV['TERM']
      when /-truecolor$/         then 16_777_216
      when /-256color$/, 'xterm' then 256
      when /-color$/, 'rxvt'     then 16
      else 256
      end
    end

    # @return [String]
    def base_path
      File.expand_path('.')
    end

  end # Configuration

  Vedeu::Configuration.configure({})

  # @!method configure
  #   @see Vedeu::Configuration.configure
  # @!method configuration
  #   @see Vedeu::Configuration.configuration
  def_delegators Vedeu::Configuration,
                 :configure,
                 :configuration

end # Vedeu
