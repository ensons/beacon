module Beacon
  module Sleep
    # Wrapper for Kernel.sleep to simplify testing.
    def self.call(seconds)
      sleep seconds
    end
  end
end
