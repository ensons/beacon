module Beacon
  # The main application foreground loop.
  class Loop
    def call
      loop do
        failsafe do
          call!
        end
      end
    end

    private

    def state
      @state ||= State.new
    end

    def failsafe
      yield
    rescue => exception
      puts exception
      Sleep.call 10
    end

    def call!
      state.call
    rescue => exception
      # Human friendly error handling
      Log.error { "#{exception.class} #{exception.message}" }
      Log.error { exception.backtrace }
      Sleep.call 10
    end
  end
end
