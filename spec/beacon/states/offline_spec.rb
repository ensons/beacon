require 'spec_helper'

RSpec.describe Beacon::States::Offline do
  describe '#call' do
    it 'is Ping', :awake do
      state = described_class.new
      expect(state.call).to be Beacon::States::Ping
    end

    it 'sos-blinks and waits 5 seconds' do
      expect(Beacon::Leds).to receive(:sos!)
      expect(Beacon::Sleep).to receive(:call).with 5
      described_class.new.call
    end
  end
end
