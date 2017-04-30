require 'spec_helper'

RSpec.describe Beacon::States::Failure do
  describe '#call' do
    it 'is Five', :awake do
      state = described_class.new
      expect(state.call).to be Beacon::States::Five
    end

    it 'flashes and waits 5 seconds' do
      expect(Beacon::Leds).to receive(:flash!)
      expect(Beacon::Sleep).to receive(:call).with 5
      described_class.new.call
    end
  end
end
