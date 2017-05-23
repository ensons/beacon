require 'spec_helper'

RSpec.describe Beacon do
  describe '.config' do
    it 'is a configuration instance' do
      configuration = described_class.config
      expect(configuration).to be_instance_of Beacon::Configuration
    end

    it 'memoizes the configuration instance' do
      expect(described_class.config).to be described_class.config
    end
  end

  describe '.configure' do
    it 'yields the configuration instance' do
      configuration = nil
      described_class.configure do |config|
        configuration = config
      end

      expect(configuration).to be described_class.config
    end
  end
end
