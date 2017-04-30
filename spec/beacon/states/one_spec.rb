require 'spec_helper'

RSpec.describe Beacon::States::One do
  describe '#call' do
    it 'is Ping', :awake do
      state = described_class.new
      expect(state.call).to be Beacon::States::Ping
    end

    it 'blinks once and waits 60 seconds' do
      expect(Beacon::Leds).to receive(:blink!).with(1)
      expect(Beacon::Sleep).to receive(:call).with 60
      described_class.new.call
    end
  end
end
