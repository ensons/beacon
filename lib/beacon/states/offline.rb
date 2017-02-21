module Beacon
  module States
    # This happens if there is no Internet connection.
    class Offline
      def call
        blink
        wait
        next_state
      end

      private

      def blink
        Leds.sos!
      end

      def wait
        Log.debug { "Waiting because I'm offline" }
        sleep 5
      end

      # There is no risk to overload any server when we're offline.
      # Try again right away.
      def next_state
        States::Ping
      end
    end
  end
end
