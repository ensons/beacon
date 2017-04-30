require 'spec_helper'

RSpec.describe Beacon::States::Three do
  describe '#call' do
    it 'is Two', :awake do
      state = described_class.new
      expect(state.call).to be Beacon::States::Two
    end

    it 'blinks 3 times and waits 60 seconds' do
      expect(Beacon::Leds).to receive(:blink!).with(3)
      expect(Beacon::Sleep).to receive(:call).with 60
      described_class.new.call
    end
  end
end
