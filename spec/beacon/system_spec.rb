require 'spec_helper'

RSpec.describe Beacon::System do
  describe '.uname' do
    it 'includes the operating system' do
      uname = Beacon::System.uname
      expect(uname).to match /Darwin|Linux/
    end
  end

  describe '.uptime' do
    it 'includes the uptime' do
      uptime = Beacon::System.uptime
      expect(uptime).to include 'load average'
    end
  end

  describe '.df' do
    it 'includes the disk space overview' do
      df = Beacon::System.df
      expect(df).to include 'Used'
    end
  end

  describe '.ruby' do
    it 'is the ruby description' do
      ruby = Beacon::System.ruby
      expect(ruby).to include 'revision'
    end
  end
end
