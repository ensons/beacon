require 'spec_helper'

RSpec.describe Beacon::States::Four do
  describe '#call' do
    it 'is Three', :awake do
      state = described_class.new
      expect(state.call).to be Beacon::States::Three
    end

    it 'blinks 4 times and waits 60 seconds' do
      expect(Beacon::Leds).to receive(:blink!).with(4)
      expect(Beacon::Sleep).to receive(:call).with 60
      described_class.new.call
    end
  end
end
