module Beacon
  module States
    # Wait 5 intervals.
    class Five
      def call
        blink
        wait
        next_state
      end

      private

      def blink
        Leds.blink! 5
      end

      def wait
        Log.debug { "Waiting because I'll retry in 5 intervals" }
        Sleep.call Beacon.config.delay
      end

      def next_state
        States::Four
      end
    end
  end
end
