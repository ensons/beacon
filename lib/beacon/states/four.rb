module Beacon
  module States
    # Wait 4 intervals.
    class Four
      def call
        blink
        wait
        next_state
      end

      private

      def blink
        Leds.blink! 4
      end

      def wait
        Log.debug { "Waiting because I'll retry in 4 intervals" }
        Sleep.call Beacon.config.delay
      end

      def next_state
        States::Three
      end
    end
  end
end
