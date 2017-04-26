require 'spec_helper'

describe Beacon do
  describe '.config' do
    it 'is a configuration instance' do
      instance = Beacon.config
      assert_instance_of Beacon::Configuration, instance
    end

    it 'memoizes the configuration instance' do
      assert_same Beacon.config, Beacon.config
    end
  end

  describe '.configure' do
    it 'yields the configuration instance' do
      instance = nil
      Beacon.configure do |config|
        instance = config
      end

      assert_same Beacon.config, instance
    end
  end
end
