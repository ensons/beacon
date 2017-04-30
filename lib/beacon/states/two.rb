module Beacon
  module States
    # Wait 2 intervals
    class Two
      def call
        blink
        wait
        next_state
      end

      private

      def blink
        Leds.blink! 2
      end

      def wait
        Log.debug { "Waiting because I'll retry in 20 seconds" }
        Sleep.call Beacon.config.delay
      end

      def next_state
        States::One
      end
    end
  end
end
