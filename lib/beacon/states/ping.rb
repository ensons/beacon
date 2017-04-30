module Beacon
  module States
    # Calls home to the server.
    class Ping
      def call
        call!
      rescue => exception
        Log.warn { [exception.class, exception.message].join ': ' }
        Log.debug { exception.backtrace }

        if Internet.online?
          States::Failure
        else
          States::Offline
        end
      end

      private

      def call!
        Log.debug { "Calling PUT #{uri}" }
        response = connect!

        if response.is_a?(Net::HTTPCreated)
          Log.info { 'Ping successfully delivered.' }
          States::Success
        else
          Log.warn { 'Server rejected ping.' }
          States::Failure
        end
      end

      def connect!
        Net::HTTP.start(uri.host, uri.port, use_ssl: ssl?) do |connection|
          return connection.put uri.path, payload.to_json, headers
        end
      end

      def uri
        URI.parse Beacon.config.endpoint.to_s + path
      end

      def path
        "/api/v1/satellites/#{Uuid.call}"
      end

      def ssl?
        uri.scheme == 'https'
      end

      def headers
        {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      end

      def payload
        {
          satellite: {
            disk: System.df,
            memory: System.free,
            ruby: System.ruby,
            system: System.uname,
            uptime: System.uptime,
            version: Beacon::Version::VERSION
          }
        }
      end
    end
  end
end
