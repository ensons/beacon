module Beacon
  # Convenience wrapper to centrally generate log messages.
  module Log
    def self.debug(&block)
      logger.debug(&block) if logger
    end

    def self.info(&block)
      logger.info(&block) if logger
    end

    def self.warn(&block)
      logger.warn(&block) if logger
    end

    def self.error(&block)
      logger.error(&block) if logger
    end

    def self.logger
      ::Beacon.config.logger
    end
    private_class_method :logger
  end
end
