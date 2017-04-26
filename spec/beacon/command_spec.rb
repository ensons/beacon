require 'spec_helper'

describe Beacon::Command do
  describe '.call' do
    it 'captures stdout' do
      stdout = Beacon::Command.call ['whoami']
      assert_equal `whoami`, stdout
    end

    it 'captures stderr' do
      stdout = Beacon::Command.call %w[mkdir /tmp/not/possible]
      assert_equal true, stdout.include?('/tmp/not')
    end
  end
end
