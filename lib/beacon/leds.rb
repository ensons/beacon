module Beacon
  # Convenience wrapper for various LED patterns.
  class Leds
    def self.blink!(count)
      Log.debug { "Blinking #{count} times..." }
      Led.new.blink times: count
    end

    def self.stare!
      Log.debug { 'Blinking 1 stare sequence' }
      Led.new.blink duration: 3
    end

    def self.flash!
      Log.debug { 'Blinking 2 flash sequence' }
      Led.new.blink times: 2, duration: 0.7, pause: 0.3
    end

    def self.sos!
      Log.debug { 'Blinking SOS sequence' }
      Led.new.blink times: 3
      Led.new.blink times: 3, duration: 0.5
      Led.new.blink times: 3
    end
  end
end
