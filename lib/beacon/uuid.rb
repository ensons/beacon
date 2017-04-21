module Beacon
  # Generates and perists a unique identifier for this device.
  module Uuid
    def self.call
      unless path.exist?
        uuid = SecureRandom.uuid
        Log.info { "Generated device UUID #{uuid}" }
        path.write uuid
      end
      path.read

    rescue StandardError, SystemCallError => exception
      Log.error { "#{exception.class} #{exception.message}" }
      Log.error { 'Could not persist device UUID' }
      nil
    end

    def self.path
      Pathname.new(Beacon.config.uuid_path)
    end
  end
end
