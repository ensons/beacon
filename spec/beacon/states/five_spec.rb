require 'spec_helper'

RSpec.describe Beacon::States::Five do
  describe '#call' do
    it 'is Four', :awake do
      state = described_class.new
      expect(state.call).to be Beacon::States::Four
    end

    it 'blinks 5 times and waits 60 seconds' do
      expect(Beacon::Leds).to receive(:blink!).with(5)
      expect(Beacon::Sleep).to receive(:call).with 60
      described_class.new.call
    end
  end
end
