require 'spec_helper'

RSpec.describe Beacon::System do
  describe '.uname' do
    it 'includes the operating system' do
      uname = described_class.uname
      expect(uname).to match(/Darwin|Linux/)
    end
  end

  describe '.uptime' do
    it 'includes the uptime' do
      uptime = described_class.uptime
      expect(uptime).to include 'load average'
    end
  end

  describe '.df' do
    it 'includes the disk space overview' do
      df = described_class.df
      expect(df).to include 'Used'
    end
  end

  describe '.ruby' do
    it 'is the ruby description' do
      ruby = described_class.ruby
      expect(ruby).to include 'revision'
    end
  end
end
