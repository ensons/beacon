module Beacon
  module States
    # Wait 1 interval
    class One
      def call
        blink
        wait
        next_state
      end

      private

      def blink
        Leds.blink! 1
      end

      def wait
        Log.debug { "Waiting because I'll retry in 1 interval" }
        sleep Beacon.config.delay
      end

      def next_state
        States::Ping
      end
    end
  end
end
