module Beacon
  # Wrapper for Kernel.sleep to simplify testing.
  module Sleep
    def self.call(seconds)
      Kernel.sleepy seconds
    end
  end
end
