require 'spec_helper'

describe Beacon::States::Ping do
  describe '#call' do
    describe '' do
      it '' do
        Beacon.config.endpoint = 'http://server.example'
        Beacon::States::Ping.new.call
      end
    end
  end
end
