module Beacon
  # Checking whether there is an Internet connection or not.
  module Internet
    def self.online?
      Log.debug { 'Testing your Internet connection...' }
      connect

    rescue => exception
      Log.debug { [exception.class, exception.message].join(': ') }
      Log.debug { 'I determined that you are OFFLINE the hard way' }
      false
    end

    def self.connect
      Timeout.timeout 3 do
        response = connect!

        if response.is_a?(Net::HTTPSuccess)
          Log.debug { 'I determined that you are online' }
          true
        else
          Log.debug { 'I determined that you are OFFLINE' }
          false
        end
      end
    end

    def self.connect!
      Net::HTTP.start(Beacon.config.online_check_host, 80) do |connection|
        return connection.head '/'
      end
    end
  end
end
