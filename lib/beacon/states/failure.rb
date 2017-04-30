module Beacon
  module States
    # The server was reached but responded in an unexpected way.
    class Failure
      def call
        blink
        wait
        next_state
      end

      private

      def blink
        Leds.flash!
      end

      def wait
        Log.debug { 'Waiting because ping failed' }
        Sleep.call 5
      end

      def next_state
        States::Five
      end
    end
  end
end
