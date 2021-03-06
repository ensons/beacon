module Beacon
  # Turns the on-board LED on or off.
  class Led
    def blink(times: 1, duration: 0.1, pause: 0.1)
      times.times do
        on!
        Sleep.call duration
        off!
        Sleep.call pause
      end
    ensure
      # Even if the process dies (e.g. due to Interrupt),
      # we must make sure the LED is not accidentally left shining.
      off!
    end

    private

    def on!
      write 1
    end

    def off!
      write 0
    end

    def write(value)
      path.write value
    rescue => exception
      Log.error { "#{exception.class} #{exception.message}" }
      Log.warn { "Could not write #{value} to #{path}" }
      nil
    end

    def path
      Pathname.new('/sys/class/leds/led0/brightness')
    end
  end
end
