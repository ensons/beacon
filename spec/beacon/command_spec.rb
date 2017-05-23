require 'spec_helper'

RSpec.describe Beacon::Command do
  describe '.call' do
    it 'captures stdout' do
      stdout = described_class.call ['whoami']
      expect(stdout).to eq `whoami`
    end

    it 'captures stderr' do
      stdout = described_class.call %w[mkdir /tmp/not/possible]
      expect(stdout).to include '/tmp/not'
    end
  end
end
