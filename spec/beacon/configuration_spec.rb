require 'spec_helper'

RSpec.describe Beacon::Configuration do
  describe '#logger' do
    it 'logs to STDOUT' do
      logger = Beacon::Configuration.new.logger
      device = logger.instance_variable_get(:@logdev).dev

      stdout_logger = ::Logger.new(STDOUT)
      stdout_device = stdout_logger.instance_variable_get(:@logdev).dev

      expect(device).to eq stdout_device
    end
  end

  describe '#endpoint' do
    it 'is the server protocol and hostname' do
      endpoint = Beacon::Configuration.new.endpoint
      expect(endpoint).to eq 'https://ensons.de'
    end
  end

  describe '#delay' do
    it 'is one minute' do
      delay = Beacon::Configuration.new.delay
      expect(delay).to eq 60
    end
  end

  describe '#uuid_path' do
    it 'is the raspberry absolute home path' do
      uuid_path = Beacon::Configuration.new.uuid_path
      expect(uuid_path).to eq '/home/pi/uuid'
    end
  end
end
