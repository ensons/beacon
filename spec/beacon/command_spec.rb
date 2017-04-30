require 'spec_helper'

RSpec.describe Beacon::Command do
  describe '.call' do
    it 'captures stdout' do
      stdout = Beacon::Command.call ['whoami']
      expect(stdout).to eq `whoami`
    end

    it 'captures stderr' do
      stdout = Beacon::Command.call %w[mkdir /tmp/not/possible]
      expect(stdout).to include '/tmp/not'
    end
  end
end
