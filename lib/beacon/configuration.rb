module Beacon
  # Holds global configuration parameters.
  class Configuration
    def logger
      return @logger if defined?(@logger)
      default_logger
    end
    attr_writer :logger

    def endpoint
      return @endpoint if defined?(@endpoint)
      default_endpoint
    end
    attr_writer :endpoint

    def delay
      return @delay if defined?(@delay)
      default_delay
    end
    attr_writer :delay

    def uuid_path
      return @uuid_path if defined?(@uuid_path)
      default_uuid_path
    end
    attr_writer :uuid_path

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

    def default_endpoint
      ENV['ENSONS_BEACON_ENDPOINT'] || 'https://ensons.de'
    end

    def default_uuid_path
      ENV['ENSONS_BEACON_UUID_PATH'] || '/home/pi/uuid'
    end

    def default_delay
      ENV['ENSONS_BEACON_DELAY'] ? ENV['ENSONS_BEACON_DELAY'].to_i : 60
    end
  end
end
