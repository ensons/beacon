module Beacon
  module States
    # The server responded successfully.
    class Success
      def call
        blink
        wait
        next_state
      end

      private

      def blink
        Leds.stare!
      end

      def wait
        Log.debug { 'Waiting because ping succeded' }
        sleep 5
      end

      def next_state
        States::Five
      end
    end
  end
end
