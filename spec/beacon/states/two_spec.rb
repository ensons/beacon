require 'spec_helper'

RSpec.describe Beacon::States::Two do
  describe '#call' do
    it 'is One', :awake do
      state = described_class.new
      expect(state.call).to be Beacon::States::One
    end

    it 'blinks 2 times and waits 60 seconds' do
      expect(Beacon::Leds).to receive(:blink!).with(2)
      expect(Beacon::Sleep).to receive(:call).with 60
      described_class.new.call
    end
  end
end
