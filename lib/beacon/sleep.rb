module Beacon
  # Wrapper for Kernel.sleep to simplify testing.
  module Sleep
    def self.call(seconds)
      Kernel.sleep seconds
    end
  end
end
