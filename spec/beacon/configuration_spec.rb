require 'spec_helper'

describe Beacon::Configuration do
  describe '#logger' do
    it 'logs to STDOUT' do
      logger = Beacon::Configuration.new.logger
      device = logger.instance_variable_get(:@logdev).dev

      stdout_logger = ::Logger.new(STDOUT)
      stdout_device = stdout_logger.instance_variable_get(:@logdev).dev

      assert_equal stdout_device, device
    end
  end

  describe '#endpoint' do
    it 'is the server protocol and hostname' do
      endpoint = Beacon::Configuration.new.endpoint
      assert_equal 'https://ensons.de', endpoint
    end
  end

  describe '#delay' do
    it 'is one minute' do
      delay = Beacon::Configuration.new.delay
      assert_equal 60, delay
    end
  end

  describe '#uuid_path' do
    it 'is the raspberry absolute home path' do
      uuid_path = Beacon::Configuration.new.uuid_path
      assert_equal '/home/pi/uuid', uuid_path
    end
  end
end
