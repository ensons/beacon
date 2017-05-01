module Beacon
  module Sleep
    # Wrapper for Kernel.sleep to simplify testing.
    def self.call(seconds)
      Kernel.sleepy seconds
    end
  end
end
