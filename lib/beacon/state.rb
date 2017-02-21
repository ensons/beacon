module Beacon
  # Holds the global state of this process.
  class State
    def initialize
      @state = States::Ping
    end

    def call
      Log.debug { "Processing state #{state}" }
      self.state = state.new.call
      Log.debug { "Transitioned to state #{state}" }
    end

    attr_accessor :state
  end
end
