module Beacon
  # Holds global configuration parameters.
  class Configuration
    def logger
      return @logger if defined?(@logger)
      default_logger
    end
    attr_writer :logger

    def logger_target
      return @logger_target if defined?(@logger_target)
      default_logger_target
    end
    attr_writer :logger_target

    def endpoint
      return @endpoint if defined?(@endpoint)
      default_endpoint
    end
    attr_writer :endpoint

    def online_check_host
      return @online_check_host if defined?(@online_check_host)
      default_online_check_host
    end
    attr_writer :online_check_host

    def delay
      return @delay if defined?(@delay)
      default_delay
    end
    attr_writer :delay

    private

    def default_logger
      result = Logger.new STDOUT
      result.formatter = default_logger_formatter
      result
    end

    def default_logger_formatter
      proc do |severity, datetime, _, message|
        human_time = datetime.strftime '%Y-%m-%d %H:%M:%S'
        output = [human_time, severity.rjust(5), '--', message, "\n"].join(' ')

        case severity
        when 'DEBUG' then "\033[2m#{output}\033[0m"
        when 'WARN'  then "\033[33m#{output}\033[0m"
        when 'ERROR' then "\033[31m#{output}\033[0m"
        else output
        end
      end
    end

    def default_logger_target
      ENV['ENSONS_BEACON_LOGGER_TARGET'] || STDOUT
    end

    def default_endpoint
      ENV['ENSONS_BEACON_ENDPOINT'] || 'https://ensons.de'
    end

    def default_online_check_host
      ENV['ENSONS_BEACON_ONLINE_CHECK_HOST'] || 'example.com'
    end

    def default_delay
      ENV['ENSONS_BEACON_DELAY'] ? ENV['ENSONS_BEACON_DELAY'].to_i : 60
    end
  end
end
