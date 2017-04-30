require 'spec_helper'

RSpec.describe Beacon do
  describe '.config' do
    it 'is a configuration instance' do
      configuration = Beacon.config
      expect(configuration).to be_instance_of Beacon::Configuration
    end

    it 'memoizes the configuration instance' do
      expect(Beacon.config).to be Beacon.config
    end
  end

  describe '.configure' do
    it 'yields the configuration instance' do
      configuration = nil
      Beacon.configure do |config|
        configuration = config
      end

      expect(configuration).to be Beacon.config
    end
  end
end
