require 'spec_helper'

describe Beacon::System do
  describe '.uname' do
    it 'includes the operating system' do
      uname = Beacon::System.uname
      assert_match(/Darwin|Linux/, uname)
    end
  end

  describe '.uptime' do
    it 'includes the uptime' do
      uptime = Beacon::System.uptime
      assert_match 'load average', uptime
    end
  end
end
