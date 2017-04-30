require 'spec_helper'

RSpec.describe Beacon::States::Success do
  describe '#call' do
    it 'is Five', :awake do
      state = described_class.new
      expect(state.call).to be Beacon::States::Five
    end

    it 'stares and waits 5 seconds' do
      expect(Beacon::Leds).to receive(:stare!)
      expect(Beacon::Sleep).to receive(:call).with 5
      described_class.new.call
    end
  end
end
