module Beacon
  module States
    # Wait 3 intervals.
    class Three
      def call
        blink
        wait
        next_state
      end

      private

      def blink
        Leds.blink! 3
      end

      def wait
        Log.debug { "Waiting because I'll retry in 30 seconds" }
        sleep Beacon.config.delay
      end

      def next_state
        States::Two
      end
    end
  end
end
