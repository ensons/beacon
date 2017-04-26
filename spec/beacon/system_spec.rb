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

  describe '.df' do
    it 'includes the disk space overview' do
      df = Beacon::System.df
      assert_match 'Used', df
    end
  end

  describe '.ruby' do
    it 'is the ruby description' do
      ruby = Beacon::System.ruby
      assert_match 'revision', ruby
    end
  end
end
