require 'spec_helper'

RSpec.describe Beacon::Sleep do
  describe '.call' do
    it 'proxies to the real sleep' do
      expect(Kernel).to receive(:sleep).with 2
      described_class.call 2
    end
  end
end
