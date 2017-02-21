# The main application namespace.
# @author Ensons Sicherheitstechnik - ensons.de
module Beacon
  # Lazy-loads and returns the global configuration instance.
  #
  # @example
  #   Beacon.config.logger = MyLogger.new
  #
  # @return [Beacon::Configuration]
  # @see .configure
  #
  def self.config
    @config ||= ::Beacon::Configuration.new
  end

  # Yields the configuration instance.
  #
  # @example
  #   Beacon.configure do |config|
  #     config.logger = MyLogger.new
  #   end
  #
  # @yieldparam [Beacon::Configuration] config global configuration instance.
  # @see .config
  #
  def self.configure
    yield config
  end

  # Resets the configuration.
  # @note This is useful for testing, since the configuration is global
  #   and persists across specs.
  # @api private
  #
  def self.reset!
    @config = nil
  end
end
