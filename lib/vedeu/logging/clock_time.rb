# frozen_string_literal: true

module Vedeu

  module Logging

    # If the system supports Process::CLOCK_MONOTONIC use that for
    # timestamps.
    #
    #    Vedeu.clock_time # => 15217.232113 (Process::CLOCK_MONOTONIC)
    #                     # => 1447196800.3098037 (Time.now)
    #
    module ClockTime

      # @return [Float|Time]
      def self.clock_time
        if defined?(Process::CLOCK_MONOTONIC)
          Process.clock_gettime(Process::CLOCK_MONOTONIC)

        else
          Time.now

        end
      end

    end # ClockTime

  end # Logging

  # @!method clock_time
  #   @see Vedeu::Logging::ClockTime
  def_delegators Vedeu::Logging::ClockTime,
                 :clock_time

end # Vedeu
