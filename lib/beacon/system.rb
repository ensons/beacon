module Beacon
  # Gathers information about the environment and the operating system.
  class System
    def self.uname
      Command.call %w(/usr/bin/env uname -a)
    end

    def self.uptime
      Command.call %w(/usr/bin/env uptime)
    end

    def self.df
      Command.call %w(/usr/bin/env df)
    end

    def self.free
      Command.call %w(/usr/bin/env free)
    end

    def self.ruby
      RUBY_DESCRIPTION
    end
  end
end
